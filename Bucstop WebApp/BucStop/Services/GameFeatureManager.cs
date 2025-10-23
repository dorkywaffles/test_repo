using System.Collections.Generic;
namespace BucStop.Services
{
    public static class GameFeatureManager
    {
        // Centralized dictionary of flags
        private static readonly Dictionary<string, bool> FeatureFlags = new()
        {
            // Flase = Disabled, True = Enabled
            //Add new games here
            { "Snake", true },
            { "Tetris", true },
            { "Pong", true },
            { "BucKart", true }
        };

        // Checks if a given game is enabled
        public static bool IsEnabled(string gameTitle)
        {
            return FeatureFlags.TryGetValue(gameTitle, out bool isEnabled) ? isEnabled : true;
        }
    }
}
