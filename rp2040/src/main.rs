#![no_std]
#![no_main]
mod util;

// Ensure we halt the program on panic (if we don't mention this crate it won't be linked)
use panic_halt as _;
use defmt_rtt as _;

use rp_pico as bsp;
use bsp::entry;
use bsp::pac;
use bsp::hal::watchdog::Watchdog;
use crate::util::*;
use embedded_hal::digital::v2::InputPin;
use usbd_serial::SerialPort;
use usb_device::{class_prelude::*, prelude::*};

const XOSC_CRYSTAL_FREQ: u32 = 12_000_000;

#[entry]
fn setup() -> ! {
    //----------------------- SETUP ----------------------------
    let mut pac = pac::Peripherals::take().unwrap();
    let sio = bsp::hal::sio::Sio::new(pac.SIO);
    let mut watchdog = Watchdog::new(pac.WATCHDOG);
    
    let clocks = bsp::hal::clocks::init_clocks_and_plls(
        XOSC_CRYSTAL_FREQ,
        pac.XOSC,
        pac.CLOCKS,
        pac.PLL_SYS,
        pac.PLL_USB,
        &mut pac.RESETS,
        &mut watchdog,
    ).ok().unwrap();
    let main_timer = bsp::hal::Timer::new(pac.TIMER, &mut pac.RESETS, &clocks);

    // Set up the USB
    let usb_bus = UsbBusAllocator::new(bsp::hal::usb::UsbBus::new(
        pac.USBCTRL_REGS,
        pac.USBCTRL_DPRAM,
        clocks.usb_clock,
        true,
        &mut pac.RESETS,
    ));
    let mut serial = SerialPort::new(&usb_bus);
    let mut usb_dev = UsbDeviceBuilder::new(&usb_bus, UsbVidPid(0x6666, 0x0301))
        .manufacturer("Yourein")
        .product("SCounter")
        .device_class(2) // Communications and CDC Control
        .build();
    
    let pins = bsp::hal::gpio::Pins::new(pac.IO_BANK0, pac.PADS_BANK0, sio.gpio_bank0, &mut pac.RESETS);

    let p1 = pins.gpio17.into_floating_input();
    let p2 = pins.gpio18.into_floating_input();
    let p3 = pins.gpio19.into_floating_input();
    let p4 = pins.gpio20.into_floating_input();
    let p5 = pins.gpio21.into_floating_input();
    let p6 = pins.gpio22.into_floating_input();
    let p7 = pins.gpio23.into_floating_input();
    //--------------------- SETUP END --------------------------
    
    //----------------------- FLAGS OR GLOBAL VARIABLES -------------------------
    let mut last_data: u8 = (0b1 << 7) - 1;
    let mut last_fetched = main_timer.get_counter();
    //--------------------- FLAGS OR GLOBAL VARIABLES END -----------------------

    loop {
        if usb_dev.poll(&mut [&mut serial]) {
            let mut buf = [0u8; 64];
            let _ = serial.read(&mut buf[..]);
        }

        if elapsed_n_millis(&main_timer.get_counter(), &last_fetched, 50) {
            let mut current_data: u8 = 0;
            current_data = current_data | (if p1.is_high().unwrap() { 1 } else { 0 });
            current_data = current_data | ((if p2.is_high().unwrap() { 1 } else { 0 }) << 1);
            current_data = current_data | ((if p3.is_high().unwrap() { 1 } else { 0 }) << 2);
            current_data = current_data | ((if p4.is_high().unwrap() { 1 } else { 0 }) << 3);
            current_data = current_data | ((if p5.is_high().unwrap() { 1 } else { 0 }) << 4);
            current_data = current_data | ((if p6.is_high().unwrap() { 1 } else { 0 }) << 5);
            current_data = current_data | ((if p7.is_high().unwrap() { 1 } else { 0 }) << 6);

            if current_data ^ last_data != 0 {
                let _ = serial.write(&[current_data, 13, 10]); // "${data}\r\n"
                let _ = serial.flush(); // I don't need this flush actually?
                last_data = current_data;
            }

            last_fetched = main_timer.get_counter();
        }
    }
}
