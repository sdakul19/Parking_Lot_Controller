# Parking_Lot_Controller
This repository contains code for a VHDL parking lot controller for ECSE 417

## Design
The controller will have a total of 6 inputs and 3 outputs. There will be an enter and exit signal that monitors cars going in and out of the lot, there will be a start and stop signal to manually put the lot into open or closed mode as well as a manual override mode for each parking state, and there will be open, full, and closed signals. 


There will be 3 parking states and an idle state: EMPTY, OPEN, CLOSED, and IDLE. Assuming the lot is at the IDLE state and closed = 1, when the START signal is high, the state will transition to EMPTY where Open = 1 and the count = 0. In EMPTY, there are 3 possible transitions. For EMPTY to go back to IDLE, the STOP signal must be high. To get to OPEN, a car must enter the lot and ENTER signal be activated and the count is updated to 1. An override or start signal will keep the state in EMPTY. When in OPEN, whenever there is an exit or enter signal the system may loop back into the open state or into the empty or closed state. The machine checks the count to make sure which state to go back to. After an exit or enter event, the system will check if the count is 20 or 0. If the count is 20, the system will move to the CLOSED state where Full = 1. If the count is 0, the system will move to the EMPTY state. If count is greater than 0 or less than 20, it will move to the back to the open state. Any OVERRIDE command will make the system loop back to the same state and allow cars to enter or exit despite the count. Aside from IDLE, whenever a start signal occurs nothing will happen and the state will remain unchanged. Whenever there is a STOP signal, the state will change to IDLE and when START is high again, the next state will change according to the count size. 
 
## Contributers
Sam Rojanasakdakul and Evan Knipp