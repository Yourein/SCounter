use rp2040_hal as bsp;
use bsp::timer::Instant;

/// Returns whether t1 - t2 >= diff is true or false.
pub fn elapsed_n_millis(t1: &Instant, t2: &Instant, diff: u64) -> bool {
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
