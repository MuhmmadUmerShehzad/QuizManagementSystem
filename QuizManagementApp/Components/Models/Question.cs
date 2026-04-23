public class Question
{
    public int QuestionID { get; set; }
    public int subjectID { get; set; }
    public string? QuestionText { get; set; }
    public int CreatedBy { get; set; }

    public int difficultyLevel { get; set; }

    public Subject? subject { get; set; }

    public int QuizID { get; set; }
}