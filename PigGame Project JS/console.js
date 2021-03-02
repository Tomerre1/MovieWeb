(function(){
    var Question = function(YourQuestion,Answers,correctAnswer){ 
        this.yourQuestion = YourQuestion;
        this.Answers = Answers;
        this.correctAnswer = correctAnswer;
    }
    Question.prototype.ShowQuestion = function(){
        console.log(this.yourQuestion)
        for(var i=0 ; i<this.Answers.length ; i++)
            console.log(i+": " + this.Answers[i]);
        var ans = prompt("Select the correct answer type a number: ");
        (ans == this.correctAnswer) ? console.log("True") : console.log("False");
    }
    var Question1 = new Question("JavaScript is the coolest programming language in the world?",['Yes','No'],0);
    var Question2 = new Question("What is the name of the course teacher?",['Tomer','Jonas','Ilia'], 1);
    var Question3 = new Question("What is the name of my dog?",['Tofi','Bobi','Loi'], 2);
    var QuestionArray = [Question1,Question2,Question3]; 
    QuestionArray[Math.floor(Math.random()*QuestionArray.length)].ShowQuestion();
})();
