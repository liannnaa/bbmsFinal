import serial
import time
import re

# Configure the serial connection
ser = serial.Serial('/dev/cu.usbmodem142201', 9600)
ser.flushInput()

# Paths to the files where the data will be written
speed_data_file = 'speed_data.txt'
block_data_file = 'block_data.txt'

while True:
    try:
        # Read a line of data from the serial port
        ser_bytes = ser.readline()
        decoded_bytes = ser_bytes.decode("utf-8").strip()

        # Check if the line indicates blocking
        if decoded_bytes in ["Blocking", "Not blocking"]:
            with open(block_data_file, 'w') as f:
                f.write(decoded_bytes)
                print(decoded_bytes)
        else:
            # Use regular expression to find numbers in the decoded string
            numbers = re.findall(r"[-+]?\d*\.\d+|\d+", decoded_bytes)
            if numbers:
                # Assuming the first number is the speed
                speed = numbers[0]

                # Write the speed data to a file
                with open(speed_data_file, 'w') as f:
                    f.write(speed)
                    print(speed)

        # Sleep for a short time before reading again
        time.sleep(0.1)

    except Exception as e:
        print(e)
        break
