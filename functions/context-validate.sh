contextValidate()
{
    verbose "must validate $1 first" 3;
    . $commandPath/../config-validation/$1.sh;
}
