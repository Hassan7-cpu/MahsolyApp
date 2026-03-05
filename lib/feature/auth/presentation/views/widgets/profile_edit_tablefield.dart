import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/widgets/custom_textfield.dart';

class ProfileEditTablefield extends StatefulWidget {
  const ProfileEditTablefield({super.key,required this.Focus, required this.text});
final FocusNode Focus;
final String text;
  @override
  State<ProfileEditTablefield> createState() => _ProfileEditTablefieldState();
}

class _ProfileEditTablefieldState extends State<ProfileEditTablefield> {
    final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  

  bool isEditing = false;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
            children: [
              Expanded(
                child: CustomTextfield(
                  controller: emailController,
                  labeltext: widget.text,
                  focusNode: widget.Focus,
                  enabled: isEditing,
                ),
              ),
              SizedBox(width: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEditing ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                  if(isEditing){
                    FocusScope.of(context).requestFocus(widget.Focus);
                  }else{
                     FocusScope.of(context).unfocus();
                  }
                },
                child: Text(isEditing ? "Save" : "Edit",style: AppTextStyle.giloryRegular16(context),),
              ),
            ],
          );
  }
}