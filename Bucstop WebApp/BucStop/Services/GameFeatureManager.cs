using System.Collections.Generic;
namespace BucStop.Services
{
    public static class GameFeatureManager
    {
        // Centralized dictionary of flags
        private static readonly Dictionary<string, bool> FeatureFlags = new()
        {
            // Flase = Disabled, True = Enabled
            { "Snake", true },
            { "Tetris", true },
            { "Pong", true } 
        };

        // Checks if a given game is enabled
        public static bool IsEnabled(string gameTitle)
        {
            return FeatureFlags.TryGetValue(gameTitle, out bool isEnabled) ? isEnabled : true;
        }
    }
}
