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
int hum;
uint8_t ReadHum(){
 {
  // variables
  int sensor_value = 0;
  float sensor_volts = 0;
  int humidity = 0;
 
  // Powering the sensor
  PWR.setSensorPower(SENS_3V3,SENS_ON);
 
  delay(15000);
 
  // Reading the analog value
  sensor_value = analogRead(ANALOG7);
  delay(100);
  sensor_value = analogRead(ANALOG7);
  delay(100);
  PWR.setSensorPower(SENS_3V3,SENS_OFF);
 
  // Calculating the volts
  sensor_volts = float(sensor_value) * 3.300 / 1023;
 
  // Calculating the light value
  humidity = int((sensor_volts * 100) / 3);
 
  return humidity;
 }}
void setup()
{
  USB.ON();

}


void loop()
{
  hum = ReadHum();
  USB.print("Humidity: ");
  USB.print(hum);
  USB.println("%RH");
}
