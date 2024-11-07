module ERTimer

import "std/colors.rl"; as clrs
import "std/time.rl"; as time
import "std/utils.rl"; as utils

#-- Name: Timer
#-- Parameter: hours: int
#-- Parameter: mins: int
#-- Parameter: secs: int
#-- Description:
#--   Creates a new `Timer` object that takes the starting
#--   hours, minutes, and seconds.
@pub class Timer [hours: int, mins: int, secs: int] {
    @const let colors = [
        clrs::Tfc.Green,
        clrs::Tfc.Yellow,
        clrs::Tfc.Blue,
        clrs::Tfc.Magenta,
        clrs::Tfc.Cyan,
    ];

    @const let color = colors[utils::iota() % len(colors)];

    @pub let hours, mins, secs = (
        hours,
        mins,
        secs
    );

    @pub fn display() {
        print(clrs::Te.Bold, color);

        print(case hours < 10 of {
            true = f"0{hours}:";
            _    = f"{hours}:";
        });
        print(case mins < 10 of {
            true = f"0{mins}:";
            _    = f"{mins}:";
        });
        println(case secs < 10 of {
            true = f"0{secs}";
            _    = secs;
        });

        print(clrs::Te.Reset);

        this.secs += 1;
        if this.secs == 60 {
            this.secs = 0;
            if this.mins == 60 {
                this.mins = 0;
                this.hours += 1;
            }
            else {
                this.mins += 1;
            }
        }
    }
}

#-- Name: run_timers
#-- Parameter: timers: list<Timer>
#-- Returns: unit
#-- Description:
#--   Takes a list of timers and will constantly
#--   display them and sleep for one second.
#--   This function does not exit.
@pub fn run_timers(timers: list): unit {
    loop {
        $"clear";
        foreach @const @ref timer in timers {
            timer.display();
        }
        sleep(time::ONE_SECOND);
    }
}
