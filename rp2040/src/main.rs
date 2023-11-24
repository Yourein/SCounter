#![no_std]
#![no_main]

use rp_pico::entry;
use defmt_rtt as _;
use embedded_hal::digital::v2::OutputPin;

// Ensure we halt the program on panic (if we don't mention this crate it won't be linked)
use panic_halt as _;

use rp_pico::hal::{
    clocks::init_clocks_and_plls,
    pac,
    sio::Sio,
    watchdog::Watchdog,
    Timer, timer::Instant,
    usb,
};

// USB Device support, Communications Class Device support
use usb_device::{class_prelude::*, prelude::*};
use usbd_serial::SerialPort;

/// Returns whether t1 - t2 >= diff is true or false.
fn elapsed_n_millis(t1: &Instant, t2: &Instant, diff: u64) -> bool {
    match t1.checked_duration_since(*t2) {
        Some(d) => {
            d.to_millis() >= diff
        },
        None => { 
            // In this usecase, t1 must be greater than t2.
            // If t1 <= t2, u32 overflow can be happened.
            true 
        }
    }
}

#[entry]
fn setup() -> ! {
    //----------------------- SETUP ----------------------------
    let mut pac = pac::Peripherals::take().unwrap();
    let sio = Sio::new(pac.SIO);
    let mut watchdog = Watchdog::new(pac.WATCHDOG);

    // Configure the clocks
    // The default is to generate a 125 MHz system clock
    let clocks = init_clocks_and_plls(
        rp_pico::XOSC_CRYSTAL_FREQ,
        pac.XOSC,
        pac.CLOCKS,
        pac.PLL_SYS,
        pac.PLL_USB,
        &mut pac.RESETS,
        &mut watchdog,
    )
    .ok()
    .unwrap();

    // Set timer
    let timer = Timer::new(pac.TIMER, &mut pac.RESETS, &clocks);

    // Set up the USB driver
    let usb_bus = UsbBusAllocator::new(usb::UsbBus::new(
        pac.USBCTRL_REGS,
        pac.USBCTRL_DPRAM,
        clocks.usb_clock,
        true,
        &mut pac.RESETS,
    ));

    // Set up the USB Communications Class Device driver
    let mut serial = SerialPort::new(&usb_bus);

    // Create a USB device.
    // Using Prototype product Vendor ID. It can be conflict with other hobby usb devices.
    let mut usb_dev = UsbDeviceBuilder::new(&usb_bus, UsbVidPid(0x6666, 0x0301))
        .manufacturer("Yourein")
        .product("SCounter")
        .serial_number("1")
        .device_class(2) // Communications and CDC Control
        .build();

    let pins = rp_pico::Pins::new(
        pac.IO_BANK0,
        pac.PADS_BANK0,
        sio.gpio_bank0,
        &mut pac.RESETS,
    );

    let mut led_pin = pins.gpio17.into_push_pull_output();
    //--------------------- SETUP END --------------------------
    
    //----------------------- FLAGS OR GLOBAL VARIABLES -------------------------
    let mut said_hello = false;
    let mut last_timer = timer.get_counter();
    //--------------------- FLAGS OR GLOBAL VARIABLES END -----------------------

    let _ = serial.write(b"LED LOW\r\n");
    loop {
        if usb_dev.poll(&mut [&mut serial]) {
            let mut buf = [0u8; 64];
            let _ = serial.read(&mut buf[..]);
        }

        if !said_hello && elapsed_n_millis(&timer.get_counter(), &last_timer, 500u64) {
            said_hello = true;
            led_pin.set_high().unwrap();
            let _ = serial.write(b"LED HIGH\r\n");
            last_timer = timer.get_counter();
        }
        
        if said_hello && elapsed_n_millis(&timer.get_counter(), &last_timer, 500u64) {
            said_hello = false;
            led_pin.set_low().unwrap();
            let _ = serial.write(b"LED LOW\r\n");
            last_timer = timer.get_counter();
        }
    }
}

// End of file
