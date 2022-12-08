/*
 * main.c
 *
 *  Created on: Dec 8, 2022
 *      Author: dcaglar2
 */
#include <stdio.h>
#include <stdint.h>

#include "linker.h"

#include "minimp3/minimp3.h"

#define MINIMP3_IMPLEMENTATION
#define MINIMP3_NO_SIMD
#define MINIMP3_NO_MP3

static mp3dec_t mp3d;

uint8_t * onchip_mem = (uint8_t *)ONCHIP_MEMORY2_0_REGION_BASE;

int main(){
	int i;
	for(i = 0; i < 8 ; i++){
		printf("The contents of memory at index %x : %x\n", i , onchip_mem[i]);
	}

//	mp3dec_init(&mp3d);
//	printf("Successfully initialized mp3 decoder");
//
//	mp3dec_frame_info_t info;
//
//	int16_t pcm[MINIMP3_MAX_SAMPLES_PER_FRAME];
//
//	int samples;
//	samples = mp3dec_decode_frame(&mp3d,onchip_mem,41087,pcm,&info);
}
