using System;
using System.Threading;
using NodaTime;

class Program
{
    static void Main()
    {
        DateTime currentDateTime = DateTime.Now;
        Console.WriteLine("Current Date and Time: " + currentDateTime);

        // Get the current instant in UTC
        Instant now = SystemClock.Instance.GetCurrentInstant();
        // Create a time zone for London
        DateTimeZone londonZone = DateTimeZoneProviders.Tzdb["Europe/London"];
        // Convert the instant to London time
        ZonedDateTime londonTime = now.InZone(londonZone);
        Console.WriteLine($"Current time in London: {londonTime}");
        Console.WriteLine($"Is Daylight Saving Time: {londonZone.GetUtcOffset(now).Equals(Offset.FromHours(1))}");
    }
}
