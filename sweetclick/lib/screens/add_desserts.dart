import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sweetclick/Services/crud.dart';

class AddDesserts extends StatefulWidget {
  const AddDesserts({super.key});
  

  @override
  State<AddDesserts> createState() => _AddDessertsState();
  
}

class _AddDessertsState extends State<AddDesserts> {
  
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController imageUrlcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  //methods for validating the fields
  
  bool validateForm(GlobalKey<FormState> _formKey){
      if(_formKey.currentState!.validate()){
        return true;
      }else{
        return false;
      }
  }

  void resetForm(bool value){
  
    descriptioncontroller.clear();
    imageUrlcontroller.clear();
    namecontroller.clear();
    pricecontroller.clear();

  }
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create desserts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: 
      SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
            
              //separador
              SizedBox(height: 8),
              //formulario
              Form(
                key: _formKey, //identificador del formulario
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:<Widget>[
                    
                  SizedBox(height: 8),
                   //campo description
                   TextFormField(
                  controller: descriptioncontroller,
                      decoration: InputDecoration(
                        labelText: "description",
                        hintText: "Enter the description",
                      

                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter the description";
                        }
                        else{
                          return null;
                        }
                      },
                ),
                SizedBox(height: 8),
                   //campo imageUrl
                   TextFormField(
                  controller: imageUrlcontroller,
                      decoration: InputDecoration(
                        labelText: "Image Url",
                        hintText: "Enter the image url",
                      

                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter the imageUrl";
                        }
                        else{
                          return null;
                        }
                      },
                ),

                   SizedBox(height: 8),
                   //campo name
                   TextFormField(
                  controller: namecontroller,
                      decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Enter your name",
                      

                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter your name";
                        }
                        else{
                          return null;
                        }
                      },
                ),
                SizedBox(height: 8),
                   //campo price
                   TextFormField(
                  controller: pricecontroller,
                  keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Price",
                        hintText: "Enter the price",
                        
                      

                      ),
                      
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter the price";
                        }
                        else{
                          return null;
                        }
                      },
                ),
                 SizedBox(height: 20,),

                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      if(validateForm(_formKey)){
                        CRUDBakery().UploadDessert(
                         description: descriptioncontroller.text.trim(), 
                         imageUrl: imageUrlcontroller.text.trim(),
                          name: namecontroller.text.trim(), 
                          price: double.tryParse(pricecontroller.text) ?? 0.0,);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added dessert")),
                          );
                      }
                    }, 
                    child: Text("Create"),
                    ),
                ),
               
                 ],
                
                ),
                 
                ),
                
            ],
          ),
        ),
      ),
      

    );
  }
}