using Microsoft.EntityFrameworkCore;
using YourApp.Models;

namespace YourApp.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<Option> Options { get; set; }
        public DbSet<Subject> Subjects { get; set; }
        public DbSet<Quiz> Quizzes { get; set; }
        public DbSet<Attempt> Attempts {get; set;}
        public DbSet<Result> Results {get; set;}
    }
}