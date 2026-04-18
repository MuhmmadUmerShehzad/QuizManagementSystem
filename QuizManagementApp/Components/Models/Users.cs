using System.ComponentModel.DataAnnotations.Schema;

namespace YourApp.Models
{
    // Be sure annotate variables with the [Column("ColumnName")] attribute the column name should match from the database
    public class User
    {
        public int UserID { get; set; }

        [Column("UserName")]
        public required string Name { get; set; }

        public required string Email { get; set; }

        [Column("UserPassword")]
        public required string PasswordHash { get; set; }

        [Column("UserRole")]
        public required string Role { get; set; }
    }
}
