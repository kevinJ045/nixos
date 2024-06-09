import time
import psutil
import notify2

# Initialize the notification system
notify2.init("System Monitor")

# Function to check and display notifications
def check_system_status():
    try:
        # Get CPU temperature (works with lm-sensors)
        temperature = psutil.sensors_temperatures()
        if 'coretemp' in temperature:
            cpu_temp = temperature['coretemp'][0].current
            if cpu_temp > 70:
                cpu_message = f"Warning: CPU temperature is high! Temperature: {cpu_temp}°C"
                cpu_notification = notify2.Notification("CPU Temperature Warning", cpu_message)
                cpu_notification.show()

        # Get battery status
        battery = psutil.sensors_battery()
        if battery is not None:
            battery_percent = battery.percent
            if battery.percent < 20:
                battery_message = f"Warning: Battery is below 20%! Battery Level: {battery_percent}%"
                battery_notification = notify2.Notification("Battery Warning", battery_message)
                battery_notification.show()

    except Exception as e:
        print(f"Error: {e}")

# Main loop to check system status periodically
while True:
    check_system_status()
    # Adjust sleep duration as needed (e.g., every 5 minutes)
    time.sleep(10)
