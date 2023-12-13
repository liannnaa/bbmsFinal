#include <Arduino_LSM9DS1.h>

const int buttonPin = 2;
bool measuring = false;
float peakAcceleration = 0;
float alpha = 0.5;
bool messagePrinted = false;
float accelerationThreshold = 1.5;

void setup() {
    Serial.begin(9600);
    while (!Serial);
    pinMode(buttonPin, INPUT_PULLUP);
    if (!IMU.begin()) {
        Serial.println("Failed to initialize IMU!");
        while (1);
    }
    Serial.println("IMU initialized!");
}

void loop() {
    float x, y, z;

    if (digitalRead(buttonPin) == LOW) {
      if(!messagePrinted){
        Serial.println("Blocking");
        delay(50);
        Serial.println("Not blocking");
        messagePrinted = true;
      }

      if (!measuring) {
        peakAcceleration = 0;
        measuring = true;
      }

      if (IMU.accelerationAvailable()) {
          IMU.readAcceleration(x, y, z);

          // Low-pass filter
            static float lastAccX = 0, lastAccY = 0, lastAccZ = 0;
            x = alpha * x + (1 - alpha) * lastAccX;
            y = alpha * y + (1 - alpha) * lastAccY;
            z = alpha * z + (1 - alpha) * lastAccZ;
            lastAccX = x;
            lastAccY = y;
            lastAccZ = z;

            // Convert acceleration to g's
            x *= 9.81;
            y *= 9.81;
            z *= 9.81;

            float currentAcceleration = sqrt(x * x + y * y + z * z);

            if (currentAcceleration > accelerationThreshold && currentAcceleration > peakAcceleration) {
                peakAcceleration = currentAcceleration;
            }
      }
    } else if (measuring) {
        measuring = false;
        Serial.print("Peak Acceleration: ");
        Serial.print(peakAcceleration);
        Serial.println(" m/s^2");
        messagePrinted = false;
    }
}