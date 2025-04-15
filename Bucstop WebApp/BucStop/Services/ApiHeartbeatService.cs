using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration; // added this
using System;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using BucStop.Models;

namespace BucStop.Services
{
    public class ApiHeartbeatService : BackgroundService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<ApiHeartbeatService> _logger;
        private readonly IConfiguration _config;
        private readonly string _healthCheckUrl;

        public ApiHeartbeatService(HttpClient httpClient, ILogger<ApiHeartbeatService> logger, IConfiguration config)
        {
            _httpClient = httpClient;
            _logger = logger;
            _config = config;
            var gateway = _config["Gateway"];
            _healthCheckUrl = $"{gateway}/health";
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    var response = await _httpClient.GetAsync(_healthCheckUrl, stoppingToken);

                    if (response.IsSuccessStatusCode)
                    {
                        _logger.LogInformation("{Category}: API Gateway is healthy.", "APIHeartbeat");
                    }
                    else
                    {
                        _logger.LogWarning("{Category}: API Gateway returned {StatusCode}.", "APIHeartbeat", response.StatusCode);
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError("{Category}: API Gateway heartbeat failed - {ErrorMessage}", "APIHeartbeat", ex.Message);
                }

                await Task.Delay(TimeSpan.FromMinutes(5), stoppingToken); // Runs every 5 minutes
            }
        }
    }
}