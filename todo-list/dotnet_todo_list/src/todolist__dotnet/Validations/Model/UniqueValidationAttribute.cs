namespace todolist__dotnet;

public class UniqueValidationAttribute : ValidationAttribute {
    private readonly
    public UniqueValidationAttribute(){}

    protected override ValidationResult isValid(object value, ValidationContext validationContext){
        if(value is string val){
            
        }
    }
}