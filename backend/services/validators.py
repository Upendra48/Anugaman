def validate_job_data(data):
    
    errors = {}
    
    if not data.get('title'):
        errors['title'] = 'Title is required.'
        
    if not data.get('company'):
        errors['company'] = 'Company is required.'
    
    salary = data.get('salary')
    if salary:
        
        try:
            int(salary)
            
        except ValueError:
            errors['salary'] = 'Salary must be a number.'
            
    return errors                