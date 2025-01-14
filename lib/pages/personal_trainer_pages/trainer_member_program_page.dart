import 'package:flutter/material.dart';
import 'package:hypegym/models/exercise.dart';
import 'package:hypegym/models/program.dart';
import 'package:hypegym/pages/gym_member_pages/program_detailed_page.dart';
import 'package:hypegym/pages/personal_trainer_pages/trainer_member_program_add_page.dart';
import 'package:hypegym/pages/personal_trainer_pages/trainer_member_program_edit_page.dart';
import 'package:hypegym/models/user.dart';
import 'package:hypegym/services/api_service.dart';

class TrainerMemberProgramPage extends StatefulWidget {
  const TrainerMemberProgramPage(this.user, {super.key});
  final UserDto user;

  @override
  State<TrainerMemberProgramPage> createState() => _TrainerMemberProgramPageState();
}

class _TrainerMemberProgramPageState extends State<TrainerMemberProgramPage> {

  final ApiService apiService = ApiService();
  late final Exercise exer;
  late final List<ProgramListDto> programList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TRAINING PROGRAM",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent.shade400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<ProgramListDto>>(
                future: apiService.getPrograms(widget.user.ID),
                builder: (context, snapshot) {

                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    programList = snapshot.data!;
                    return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(color: Colors.white,),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return
                                   Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ListTile(
                                      leading: SizedBox(
                                        width: 50,
                                        height: 100,
                                        child: Icon(Icons.fitness_center_outlined, color: Colors.greenAccent.shade400,),
                                      ),
                                      trailing: const Icon(Icons.arrow_circle_right_outlined, color: Colors.white, size: 20.0,),
                                      title: Text(snapshot.data![i].exercise.name),
                                      subtitle: Text(
                                        "${snapshot.data![i].set.toString()} x ${snapshot.data![i].rep.toString()}",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      textColor: Colors.white,
                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProgramDetailedPage(snapshot.data![i].exercise))),
                                    ),
                                  );
                        }
                    );
                  } else if(snapshot.hasData && snapshot.data!.isEmpty) {
                    print("gidi");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TrainerMemberProgramAddPage(widget.user)));
                  }
                  else if(!snapshot.hasData)
                    print("no data");
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrainerMemberProgramEditPage(programList,widget.user)));
        },
        backgroundColor: Colors.greenAccent.shade400,
        foregroundColor: Colors.black,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
