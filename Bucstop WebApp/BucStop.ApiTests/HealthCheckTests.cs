using System;
using System.Net.Http;
using System.Threading.Tasks;
using NUnit.Framework;

namespace BucStop.ApiTests
{
    public class HealthCheckTests
    {
        // Use the running app’s URL; change if your port changes later.
        private static readonly string BaseUrl =
            (Environment.GetEnvironmentVariable("TEST_BASE_URL") ?? "https://localhost:7182").TrimEnd('/');

        // Prefer trusting dev certs via: dotnet dev-certs https --trust
        private static readonly HttpClient Http = new HttpClient();

        [Test]
        public async Task Health_Returns200_AndHealthyBody()
        {
            var res = await Http.GetAsync($"{BaseUrl}/health");

            Assert.IsTrue(res.IsSuccessStatusCode,
                $"Expected 2xx but got {(int)res.StatusCode} {res.ReasonPhrase}");

            var body = await res.Content.ReadAsStringAsync();
            StringAssert.Contains("Healthy", body, "Health response body did not contain 'Healthy'.");
        }
    }
}
