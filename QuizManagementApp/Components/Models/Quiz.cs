public class Quiz
{
    public int QuizID { get; set; }
    public string? Title { get; set; }
    public int SubjectID { get; set; }
    public int CreatedBy { get; set; }
    public int Duration { get; set; }
    public bool RandomizeQuestions { get; set; }
    public bool ShuffleOptions { get; set; }
}