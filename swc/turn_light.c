#include "tpl_os.h"
#include <stdio.h>

// This is where your Turn Light SWC logic goes
TASK(blink_task) {
    static int light_on = 0;
    light_on = !light_on;
    
    if (light_on) {
        printf("[ECU] Turn Light: ON\n");
    } else {
        printf("[ECU] Turn Light: OFF\n");
    }

    TerminateTask();
}

// Required for Trampoline's startup
int main(void) {
    StartOS(std);
    return 0;
}