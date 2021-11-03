/**@author: Luca Antognarelli*/

/**
 * Checking that the user has entered all the values and that they are correct
 * @returns bool
 */
function CheckValue()
{
    var matricola = document.shByMatricola.matricola.value;
    var surname = document.shByMatricola.surname.value; 

    var validValue = /^([0-9])/; //Range of valid value

    if(matricola == "")
    {
        alert("Empty value Matricola");
        document.shByMatricola.matricola.focus();
        return false;
    }

    else if(!validValue.test(matricola))
    {
        alert("Invalid value Matricola");
        document.shByMatricola.matricola.focus();
        return false;
    }

    if(surname == "")
    {
        alert("Empty value Surname");
        document.shByMatricola.surname.focus();
        return false;
    }
    
    /**Evrything is ok, submit data*/
    document.shByMatricola.action = "function/function.php";
    document.shByMatricola.submit();
}