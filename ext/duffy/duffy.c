//
//  main.c
//  display cpu load across all cores
//
//  Created by Jacob Duffy on 2017-11-15.
//  Copyright © 2017 Jacob Duffy. All rights reserved.
//


#include <mach/mach_host.h>     // cpu info
#include <stdio.h>              // printf
#include <unistd.h>             // sleep


int main(int argc, const char * argv[]) {

    // EXAMPLE USAGE FOUND HERE: https://github.com/yujitach/MenuMeters
    natural_t cpu_count;
    processor_cpu_load_info_t processor_tick_info;
    mach_msg_type_number_t processorInfoCount;

    // Request inital CPU ticks data.
    host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &cpu_count, (processor_info_array_t *)&processor_tick_info, &processorInfoCount);
   
    
    uint64_t idle_ticks[cpu_count];
    uint64_t used_ticks[cpu_count];
    uint64_t percent[cpu_count];

    // Store inital ticks
    for( int i = 0; i < cpu_count; i++ ) {
        idle_ticks[i] = processor_tick_info[i].cpu_ticks[CPU_STATE_IDLE];
        used_ticks[i] = processor_tick_info[i].cpu_ticks[CPU_STATE_USER] +
                        processor_tick_info[i].cpu_ticks[CPU_STATE_NICE] +
                        processor_tick_info[i].cpu_ticks[CPU_STATE_SYSTEM];
    }

    // Wait a little bit and request the ticks again.
    usleep(200000);
    host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &cpu_count, (processor_info_array_t *)&processor_tick_info, &processorInfoCount);
    
    for( int i = 0; i < cpu_count; i++ ) {
        idle_ticks[i] = processor_tick_info[i].cpu_ticks[CPU_STATE_IDLE] - idle_ticks[i];
        used_ticks[i] = processor_tick_info[i].cpu_ticks[CPU_STATE_USER] +
                        processor_tick_info[i].cpu_ticks[CPU_STATE_NICE] +
                        processor_tick_info[i].cpu_ticks[CPU_STATE_SYSTEM] - used_ticks[i];
        
        percent[i] = 1000 * (used_ticks[i]) / (used_ticks[i] + idle_ticks[i]);
        
        // Print out each CPU percentage with 1 decimal point accuracy
        // Example:
        // 45.0 13.0 47.5 21.7
        printf("%llu.%.1llu ", percent[i] / 10, percent[i] % 10 );
    }
    
    printf("\n");
    return 0;
}
