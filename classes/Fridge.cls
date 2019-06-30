public class Fridge {
    public String modelNumber;
    public Integer numberInStock;
    public static final Integer stockThreShold = 5;
    public Fridge(){
        modelNumber = 'max-45';
        numberInStock = 43;
    }
    
    public void updateStock(Integer justSold){
        numberInStock = numberInStock-justSold;
    }
    public static void toDebug(Fridge aFridge){
        System.debug('model num'+aFridge.modelNumber);
        System.debug('number in stock'+afridge.numberInStock);
    }
}