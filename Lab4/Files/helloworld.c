/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xiomodule.h"

#define SW_UP 0x80
#define SW_DOWN 0x40
#define SW_LEFT 0x20
#define SW_RIGHT 0x10
#define SW 0xF0
#define COUNTER 0xF
#define BYTE_REQUIRED 3


int main()
{
	init_platform();

	xil_printf("Start Program\n\r");

	u32 data;
	u32 led = 0x00;
	u32 disp;
	u8 buffer;
	XIOModule gpi;
	XIOModule gpo;

	data = XIOModule_Initialize(&gpi, XPAR_IOMODULE_0_DEVICE_ID);
	data = XIOModule_Start(&gpi);

	data = XIOModule_Initialize(&gpo, XPAR_IOMODULE_0_DEVICE_ID);
	data = XIOModule_Start(&gpo);


	while(1){
		data = XIOModule_DiscreteRead(&gpi, 1);
		if(data & SW_UP)
			xil_printf("Chaiwat Ekkaewnumchai\n\r");
		else if(data & SW_DOWN)
			xil_printf("Current count value is %x\n\r", (data & COUNTER));
		else if(data & SW_LEFT){
			disp = 0;
			int byte_read = 0;
			while(byte_read < BYTE_REQUIRED)
				if(XIOModule_Recv(&gpi, &buffer, 1) != 0){
					//xil_printf("%x", buffer);
					if(buffer >= '0' && buffer <= '9')
						disp = (disp << 4) | (buffer - '0');
					else if(buffer >= 'A' && buffer <= 'F')
						disp = (disp << 4) | (buffer - 'A' + 10);
					else
						disp = (disp << 4);
					byte_read++;
				}
		} else if(data & SW_RIGHT)
			led = (0x8000 | (led >> 1));


		// light LEDs
		XIOModule_DiscreteWrite(&gpo, 1, led);
		// display seven segment
		XIOModule_DiscreteWrite(&gpo, 2, disp);
		// signal to hardware that the buttons are evaluated
		XIOModule_DiscreteWrite(&gpo, 3, (data & SW) >> 4);

	}


	cleanup_platform();
	return 0;
}
