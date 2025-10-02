using Microsoft.AspNetCore.Mvc;

namespace BucStop.Controllers
{
    public class HelloController : Controller
    {
        // GET /hello
        [HttpGet("/hello")]
        public IActionResult Index()
        {
            ViewData["Title"] = "Hello World";
            return View();   // looks for Views/Hello/Index.cshtml
        }
    }
}
