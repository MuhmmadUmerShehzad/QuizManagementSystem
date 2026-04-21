using YourApp.Models;

namespace YourApp.Services
{
    public class sessionService
    {
        public User? CurrentUser { get; set; }

        public bool isLoggedIn => CurrentUser != null;
    }
}