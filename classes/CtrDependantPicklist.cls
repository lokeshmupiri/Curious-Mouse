public class CtrDependantPicklist {

    public string selectedState {get;set;}
    public string selectedCity {get;set;}
    public List<SelectOption> cities {get;set;}

    public List<SelectOption> getStates() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--- None ---'));       
        options.add(new SelectOption('TN','Tamil Nadu'));
        options.add(new SelectOption('KN','Kerala'));
        return options;
    }

    public PageReference getCities()
    {
        cities = new List<SelectOption>();
        if(selectedState == 'TN')
        {      
            cities.add(new SelectOption('CHE','Chennai'));
            cities.add(new SelectOption('CBE','Coimbatore'));
        }
        else if(selectedState == 'KN')
        {      
            cities.add(new SelectOption('COA','Coachin'));
            cities.add(new SelectOption('MVL','Mavelikara'));
        }
        else
        {
            cities.add(new SelectOption('None','--- None ---'));
        }     
        return null;
    }

}