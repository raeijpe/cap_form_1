using {com.demo.cap.test as test} from '../db/schema';


service RegForm {
     entity Form as projection on test.Form;
     entity Category as projection on test.Category;
     entity CategoryAssignment as projection on test.CategoryAssignment;
}