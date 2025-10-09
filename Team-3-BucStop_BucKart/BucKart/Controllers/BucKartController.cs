using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace BucKart
{
    [ApiController]
    [Route("[controller]")]
    public class BucKartController : ControllerBase
    {
        private readonly ILogger<BucKartController> _logger;
        private readonly IConfiguration _config;

        public BucKartController(ILogger<BucKartController> logger, IConfiguration config)
        {
            _logger = logger;
            _config = config;
        }

        [HttpGet]
        public IActionResult Get()
        {
            try
            {
                string gameURL = _config["MicroserviceUrls:BucKart"] ?? "http://localhost:1950/js/buckart.js";
                string imgURL = _config["MicroserviceUrls:Image"] ?? "http://localhost:1950/images/buckart.jpg";

                var info = new List<GameInfo>
        {
            new GameInfo
            {
                Id = 4,
                Title = "BucKart",
                Content = gameURL,
                Author = "Fall 2025 Semester",
                DateAdded = "10/1/2025",
                Description = "BucKart is a driving arcade game where the player moves a car, avoiding obstacles and driving to the finish line.",
                HowTo = "Control with arrow keys.",
                Thumbnail = imgURL
            }
        };

                return Ok(info);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in BucKartController.Get()");
                return StatusCode(500, new { error = ex.Message });
            }
        }

    }
}
