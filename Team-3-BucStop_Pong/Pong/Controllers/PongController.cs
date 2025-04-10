using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

using Microsoft.Extensions.Caching.Distributed;
using System.Text.Json;

namespace Pong
{
    [ApiController]
    [Route("[controller]")]
    public class PongController : ControllerBase
    {
        private readonly ILogger<PongController> _logger;
        private readonly IConfiguration _config;
        private static string gameURL;

        public PongController(ILogger<PongController> logger, IConfiguration config)
        {
            _logger = logger;
            _config = config;
            gameURL = _config["MicroserviceUrls:Pong"];
        }

        private static readonly List<GameInfo> TheInfo = new List<GameInfo>
        {
            new GameInfo { 
                Id = 3,
                Title = "Pong",
                //Content = "~/js/pong.js",
                //Content = "https://localhost:1941/js/pong.js",
                Content = gameURL,
                Author = "Fall 2023 Semester",
                DateAdded = "",
                Description = "Pong is a classic arcade game where the player uses a paddle to hit a ball against a computer's paddle. Either party scores when the ball makes it past the opponent's paddle.",
                HowTo = "Control with arrow keys.",
                Thumbnail = "/images/pong.jpg"
            }

        };

        [HttpGet]
        public IEnumerable<GameInfo> Get()
        {
            // Confirm the Content URL is assigned if it was not available when initialized
            if (TheInfo[0].Content == null)
            {
                TheInfo[0].Content = gameURL;
            }
            return TheInfo;
        }
    }
}