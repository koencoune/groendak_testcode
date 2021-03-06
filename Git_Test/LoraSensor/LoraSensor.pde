/*
    ------ Waspmote Pro Code Example --------

    Explanation: This is the basic Code for Waspmote Pro

    Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L.
    http://www.libelium.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Put your libraries here (#include ...)
#include <WaspSensorAgr_v20.h>
#include <WaspSX1272.h>
#include <WaspFrame.h>
float temp,hum,LDR,solar,water,PT;
// Define private key to encrypt message  
char nodeID[] = "403476432"; 

// define the destination address to send packets
uint8_t rx_address = 1;

// status variable
int8_t e;
void setup()
{
  // put your setup code here, to run once:
  USB.ON();
  USB.println(F("start"));
  delay(100);

  // Turn on the sensor board
  SensorAgrv20.ON();
  
  // Turn on the RTC
  RTC.ON();
  sx1272.ON();
  frame.setID(nodeID); 
  // Select frequency channel
  e = sx1272.setChannel(CH_12_868);
  USB.print(F("Setting Channel CH_11_868.\t state ")); 
  USB.println(e);

  // Select implicit (off) or explicit (on) header mode
  e = sx1272.setHeaderON();
  USB.print(F("Setting Header ON.\t\t state "));  
  USB.println(e); 

  // Select mode: from 1 to 10
  e = sx1272.setMode(1);  
  USB.print(F("Setting Mode '1'.\t\t state "));
  USB.println(e);  

  // select CRC on or off
  e = sx1272.setCRC_ON();
  USB.print(F("Setting CRC ON.\t\t\t state "));
  USB.println(e);  

  // Select output power (Max, High or Low)
  e = sx1272.setPower('H');
  USB.print(F("Setting Power to 'H'.\t\t state "));  
  USB.println(e); 

  // Select the node address value: from 2 to 255
  e = sx1272.setNodeAddress(28);
  USB.print(F("Setting Node Address to '5'.\t state "));
  USB.println(e);
  USB.println();

  delay(1000);  

  USB.println(F("----------------------------------------"));
  USB.println(F("Sending:")); 
  USB.println(F("----------------------------------------"));
}


void loop()
{
USB.println(F("test1"));
  SensorAgrv20.setSensorMode(SENS_ON, SENS_AGR_TEMPERATURE);
  USB.println(F("test2"));
  SensorAgrv20.setSensorMode(SENS_ON, SENS_AGR_HUMIDITY);
  USB.println(F("test3"));
  SensorAgrv20.setSensorMode(SENS_ON, SENS_AGR_LDR);
  USB.println(F("test4"));
  SensorAgrv20.setSensorMode(SENS_ON, SENS_AGR_PT1000);
  USB.println(F("test5"));
  SensorAgrv20.setSensorMode(SENS_ON, SENS_AGR_RADIATION);
  USB.println(F("test6"));
  SensorAgrv20.setSensorMode(SENS_ON, SENS_AGR_WATERMARK_2);
  USB.println(F("test7"));
  delay(15000);
  
  // Read the temperature sensor 
  temp = SensorAgrv20.readValue(SENS_AGR_TEMPERATURE);
  USB.println(F("test8"));
  hum = SensorAgrv20.readValue(SENS_AGR_HUMIDITY);
  USB.println(F("test9"));
  LDR = SensorAgrv20.readValue(SENS_AGR_LDR);
  USB.println(F("test10"));
  PT = SensorAgrv20.readValue(SENS_AGR_PT1000);
  USB.println(F("test11"));
  solar = SensorAgrv20.readValue(SENS_AGR_RADIATION)/0.0002;
  USB.println(F("test12"));
  water = SensorAgrv20.readValue(SENS_AGR_WATERMARK_2);
  USB.println(F("test13"));
  // Turn off the sensor
  SensorAgrv20.setSensorMode(SENS_OFF, SENS_AGR_TEMPERATURE);
  USB.println(F("test14"));
  SensorAgrv20.setSensorMode(SENS_OFF, SENS_AGR_HUMIDITY);
  USB.println(F("test15"));
  SensorAgrv20.setSensorMode(SENS_OFF, SENS_AGR_LDR);
  USB.println(F("test16"));
  SensorAgrv20.setSensorMode(SENS_OFF, SENS_AGR_PT1000);
  USB.println(F("test17"));
  SensorAgrv20.setSensorMode(SENS_OFF, SENS_AGR_RADIATION);
  USB.println(F("test18"));
  SensorAgrv20.setSensorMode(SENS_OFF, SENS_AGR_WATERMARK_2);
  USB.println(F("test19"));
  // Part 2: USB printing
  // Print the temperature value through the USB
  USB.print(F("Temperature: "));
  USB.print(temp);
  USB.println(F("ºC"));
  USB.print("Humidity: ");
  USB.print(hum);
  USB.println("%RH");
  USB.print("Luminosity: ");
  USB.print(LDR);
  USB.println("V");
  USB.print("PT1000: ");
  USB.print(PT);
  USB.println("ºC");
  USB.print("Radiation: ");
  USB.print(solar);
  USB.println("umol·m-2·s-1");
  USB.print("Frequency: ");
  USB.print(water);
  USB.println("Hz");
  frame.createFrame(ASCII);
  frame.addSensor(SENSOR_TCB,temp);
  frame.addSensor(SENSOR_HUMB,hum);
  frame.addSensor(SENSOR_LW,LDR);
  frame.addSensor(SENSOR_TD,PT);
  frame.addSensor(SENSOR_SD,solar);
  frame.addSensor(SENSOR_WV,water);
  frame.showFrame(); 
  e = sx1272.sendPacketTimeoutACK( rx_address, frame.buffer, frame.length);

  // Check sending status
  if (e == 0)
  {
    USB.println(F("Packet sent OK"));    
  }
  else 
  {
    USB.println(F("Error sending the packet"));  
    USB.print(F("state: "));
    USB.println(e, DEC);
  } 
  
  USB.println();

  delay(1000);

}
