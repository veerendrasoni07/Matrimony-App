import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/controller/auth_controller.dart';
import 'package:matrimony_app/provider/user_provider.dart';

class SetupProfile extends ConsumerWidget {
  const SetupProfile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(child: PersonInformation())
    );
  }
}

class PersonInformation extends ConsumerStatefulWidget {
  PersonInformation({super.key});

  @override
  ConsumerState<PersonInformation> createState() => _PersonInformationState();
}

class _PersonInformationState extends ConsumerState<PersonInformation> {
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController motherTongueController = TextEditingController();
  final TextEditingController maritalController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController subcasteController = TextEditingController();
  late String selectState;
  late String selectMarital;
  final List<String> maritalList=[
    'Never Married',
    'Divorced',
    'Widowed',
    'other'
  ];
  late String selectDiet;
  final List<String> dietList = [
    'Vegetarian',
    'Non-Vegetarian',
    'Vegan',
    'Other'
  ];

  late String selectWork;
  final List<String> worksWithList = [
    'Private Sector',
    'Government/Public Sector',
    'Defense/Civil Services',
    'Business/Self Employed',
    'Not Working',
    'Other',
  ];

  late String selectFamilyType;
  final List<String> familyTypeList = [
    'Nuclear',
    'Joint',
    'Other'
  ];

  String? selectWorkRole;
  final List<String> businessRole = [
    // --- Management & Leadership ---
    'Management: CEO (Chief Executive Officer)',
    'Management: COO (Chief Operating Officer)',
    'Management: CFO (Chief Financial Officer)',
    'Management: CTO (Chief Technology Officer)',
    'Management: CMO (Chief Marketing Officer)',
    'Management: CHRO (Chief Human Resources Officer)',
    'Management: President',
    'Management: Vice President (VP)',
    'Management: Director',
    'Management: General Manager',
    'Management: Department Manager',
    'Management: Team Lead/Supervisor',
    'Management: Program Manager',
    'Management: Project Manager',
    'Management: Product Manager',
    'Management: Operations Manager',
    // --- Finance & Accounting ---
    'Finance: Accountant',
    'Finance: Auditor',
    'Finance: Financial Analyst',
    'Finance: Financial Controller',
    'Finance: Finance Manager',
    'Finance: Treasurer',
    'Finance: Bookkeeper',
    'Finance: Payroll Specialist',
    'Finance: Budget Analyst',
    'Finance: Investment Analyst',
    'Finance: Risk Manager',
    'Finance: Credit Analyst',
    'Finance: Actuary',
    'Finance: Banking Professional', // Added this as per your example
    // --- Sales & Business Development ---
    'Sales: Sales Representative',
    'Sales: Account Manager',
    'Sales: Business Development Manager',
    'Sales: Sales Manager',
    'Sales: E-commerce Manager',
    // --- Marketing & Communications ---
    'Marketing: Marketing Specialist',
    'Marketing: Marketing Manager',
    'Marketing: Brand Manager',
    'Marketing: Digital Marketing Specialist',
    'Marketing: Social Media Manager',
    'Marketing: Content Strategist',
    'Marketing: Market Research Analyst',
    'Marketing: Public Relations (PR) Specialist',
    'Marketing: Communications Manager',
    // --- Human Resources (HR) ---
    'HR: HR Generalist',
    'HR: HR Manager',
    'HR: Recruiter/Talent Acquisition',
    'HR: HR Business Partner',
    'HR: Compensation & Benefits Specialist',
    'HR: Training & Development Manager',
    // --- Operations & Supply Chain ---
    'Operations: Operations Analyst',
    'Operations: Supply Chain Manager',
    'Operations: Logistics Manager',
    'Operations: Procurement Manager',
    'Operations: Inventory Manager',
    'Operations: Production Manager',
    'Operations: Quality Assurance (QA) Manager',
    // --- IT & Technology (Business Focused) ---
    'IT: Business Analyst (IT)',
    'IT: Systems Analyst',
    'IT: IT Project Manager',
    'IT: Data Analyst (BI)',
    // --- Consulting & Advisory ---
    'Consulting: Management Consultant',
    'Consulting: Strategy Consultant',
    'Consulting: Financial Advisor',
    // --- Legal & Compliance (Business) ---
    'Legal: Corporate Counsel',
    'Legal: Compliance Officer',
    'Legal: Contract Manager',
    // --- Administration & Support ---
    'Admin: Executive Assistant',
    'Admin: Administrative Manager',
    'Admin: Office Manager',
    'Admin: Customer Service Manager',
    // --- Entrepreneurship ---
    'Entrepreneur: Founder/Co-founder',
    'Entrepreneur: Business Owner',
    // --- Other Specialized Business Roles ---
    'Specialized: Business Intelligence (BI) Analyst',
    'Specialized: Economist',
    'Specialized: Real Estate Professional',
    'Specialized: Insurance Professional',
    'Other Business Role',
  ];

  final List<String> itRoles = [
    // --- Software Development & Engineering ---
    'Development: Software Developer/Engineer (Backend, Frontend, Full Stack)',
    'Development: Mobile App Developer (iOS, Android, Cross-platform)',
    'Development: Web Developer (Frontend, Backend, Full Stack)',
    'Development: Game Developer',
    'Development: Embedded Systems Engineer',
    'Development: DevOps Engineer',
    'Development: QA Engineer/Software Tester',
    'Development: Solutions Architect',
    'Development: Technical Lead/Team Lead (Development)',
    'Development: Software Development Manager',
    // --- Data & Analytics ---
    'Data: Data Scientist',
    'Data: Data Analyst',
    'Data: Data Engineer',
    'Data: Business Intelligence (BI) Analyst/Developer',
    'Data: Machine Learning Engineer',
    'Data: Database Administrator (DBA)',
    'Data: Data Architect',
    // --- IT Infrastructure & Operations ---
    'Infrastructure: Network Engineer/Architect',
    'Infrastructure: Systems Administrator',
    'Infrastructure: Cloud Engineer/Architect',
    'Infrastructure: Site Reliability Engineer',
    'Infrastructure: IT Support Specialist/Help Desk Technician',
    'Infrastructure: IT Operations Manager',
    // --- Cybersecurity ---
    'Security: Cybersecurity Analyst',
    'Security: Security Engineer',
    'Security: Penetration Tester/Ethical Hacker',
    'Security: Security Architect',
    'Security: Chief Information Security Officer',
    // --- Design & User Experience ---
    'Design: UI (User Interface) Designer',
    'Design: UX (User Experience) Designer',
    'Design: UX Researcher',
    'Design: Product Designer',
    // --- IT Management & Strategy ---
    'Management: IT Manager',
    'Management: IT Project Manager',
    'Management: IT Program Manager',
    'Management: Product Owner (Agile/Scrum)',
    'Management: Scrum Master',
    'Management: Chief Technology Officer (CTO)', // Can also be under general management
    'Management: Chief Information Officer (CIO)', // Can also be under general management
    // --- Specialized IT Roles ---
    'Specialized: ERP Consultant/Analyst (e.g., SAP, Oracle)',
    'Specialized: CRM Administrator/Developer (e.g., Salesforce)',
    'Specialized: Technical Writer (IT)',
    'Specialized: IT Auditor',
    'Specialized: Cloud Support Engineer',
    'Other IT Role',
  ];

  final List<String> governmentJobsListRevised = [
    // --- Public Administration & Governance ---
    'Administration: Civil Service Officer (National/Federal)',
    'Administration: State/Provincial Service Officer',
    'Administration: Local Government Administrator',
    'Administration: Policy Analyst / Advisor',
    'Administration: Public Records Clerk / Officer',
    'Administration: Election Official',
    'Administration: Foreign Service / Diplomat',
    // --- Defense, Law Enforcement & Public Safety ---
    'Security: Military Personnel',
    'Security: Police Officer / Law Enforcement Agent',
    'Security: Border Patrol / Customs Officer',
    'Security: Intelligence Analyst / Officer',
    'Security: Firefighter',
    'Security: Emergency Management Specialist',
    'Security: Corrections Officer',
    // --- Public Finance & Economics ---
    'Finance: Tax Inspector / Revenue Officer',
    'Finance: Government Auditor / Accountant',
    'Finance: Budget Analyst (Public Sector)',
    'Finance: Economist (Public Policy)',
    'Finance: Central Bank Staff / Officer',
    // --- Legal & Judiciary ---
    'Legal: Public Prosecutor / Government Attorney',
    'Legal: Judge / Magistrate / Judicial Officer',
    'Legal: Court Administrator / Clerk',
    'Legal: Legal Counsel (Government Agency)',
    // --- Public Works & Infrastructure ---
    'Infrastructure: Civil Engineer',
    'Infrastructure: Urban & Regional Planner',
    'Infrastructure: Transportation Officer / Planner (Public)',
    'Infrastructure: Public Utilities Manager / Technician',
    // --- Healthcare & Social Services (Public Sector) ---
    'Healthcare: Public Health Officer / Administrator',
    'Healthcare: Doctor',
    'Healthcare: Nurse',
    'Healthcare: Social Worker (Government Agency)',
    'Healthcare: Public Health Inspector',
    // --- Education (Public Sector) ---
    'Education: Public School Teacher / Educator',
    'Education: Professor / Lecturer (Public University/College)',
    'Education: Education Administrator (Public System)',
    'Education: Public Librarian',
    // --- Science, Research & Environment (Public Sector) ---
    'Science: Government Scientist / Researcher (e.g., Environmental, Agricultural)',
    'Science: Environmental Protection Officer',
    'Science: Park Ranger / Conservation Officer',
    'Science: Meteorologist (National Weather Service)',
    // --- Arts, Culture & Archives (Public Sector) ---
    'Culture: Museum Curator / Archivist (Public Institution)',
    'Culture: Arts Administrator (Public Council/Agency)',
    // --- General Government Support Roles ---
    'Support: IT Specialist / Manager (Government)',
    'Support: Human Resources Specialist (Government)',
    'Support: Public Information Officer / Communications',
    'Support: Administrative Support Staff (Government)',
    'Other Public Sector / Government Role',
  ];

  late String college ;
  String? education;
  final List<String> educationQualification = [
    'B.E/B.Tech',
    'M.E/M.Tech',
    'B.Sc',
    'M.Sc',
    'B.A',
    'M.A',
    'B.Com',
    'M.Com',
    'B.Arch',
    'M.Arch',
    'B.Ed',
    'M.Ed',
    'B.Pharm',
    'M.Pharm',
    'High School',
    'Diploma',
    'other'
  ];
  final List<String> statesList = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli',
    'Daman and Diu',
    'Delhi',
    'Lakshadweep',
    'Puducherry'
  ];

  late String personIncome;
  final List<String> incomeListINR = [
    'Less than ₹2,50,000',
    '₹2,50,000 - ₹4,99,999',
    '₹5,00,000 - ₹7,49,999',
    '₹7,50,000 - ₹9,99,999',
    '₹10,00,000 - ₹14,99,999',
    '₹15,00,000 - ₹19,99,999',
    '₹20,00,000 - ₹24,99,999',
    '₹25,00,000 or more',
    'Prefer not to say',
  ];

  late String selectReligion;
  final List<String> religionList = [
    'Hinduism',
    'Islam',
    'Christianity',
    'Buddhism',
    'Jainism'
  ];
  late String selectCaste;
  final List<String> casteList = [
    'Agrawal',
    'Brahmin-Gaur',
    'Gupta',
    'Patel'
    'Sonar'
  ];
  late String selectMotherTongue;
  final List<String> motherTongue = [
    'Hindi',
    'English',
    'Urdu',
  ];

  String? selectGender;

  Future<void> selectDateOfBirth(BuildContext context)async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );
    if(pickedDate!=null){
      datePickerController.text = pickedDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                "Hey ${user!.fullname}!\nPlease Complete Your Profile. ",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Personal Information",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: 20,),
              Text(
                  "Gender",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              Column(
                children: [
                  RadioListTile(
                      value:'Male' ,
                      title: Text("Male"),
                      groupValue: selectGender,
                      onChanged: (value){
                        setState(() {
                          selectGender = value!;
                        });
                      }
                  ),RadioListTile(
                      value:'Female' ,
                      title: Text("Female"),
                      groupValue: selectGender,
                      onChanged: (value){
                        setState(() {
                          selectGender = value!;
                        });
                      }
                  ),RadioListTile(
                      value:'Others' ,
                      title: Text("Other"),
                      groupValue: selectGender,
                      onChanged: (value){
                        setState(() {
                          selectGender = value!;
                        });
                      }
                  )
                ],
              ),
              SizedBox(height: 10,),
              Text(
                  "Date Of Birth",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              // DOB
              TextField(
                controller: datePickerController,
                decoration: InputDecoration(
                  label: Text("Date Of Birth"),
                  hintText: "Select DOB",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onTap: (){
                  setState(()async {
                    await selectDateOfBirth(context);
                  });
                },
              ),
              SizedBox(height: 10,),
              Text(
                  "State",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              CustomDropdown(
                  items: statesList,
                  hintText: "Select State",
                  onChanged: (value){
                    selectState = value!;
                  }
              ),
              SizedBox(height: 10,),
              //city
              Text(
                  "City",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  label: Text("Enter your city name"),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                  "Locality",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              TextField(
                controller: addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  label: Text("Locality"),
                  hintText: "Enter your locality",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                  "Religion",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              CustomDropdown(
                  items: religionList,
                  hintText: "Select Religion",
                  onChanged: (value){
                    selectReligion = value!;
                  }
              ),
              SizedBox(height: 10,),
              Text(
                  "Caste",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              CustomDropdown(
                  items: casteList,
                  hintText: "Select Caste",
                  onChanged: (value){
                   selectCaste = value!;
                  }
              ),
              SizedBox(height: 10,),
              Text(
                  "Sub-Caste",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              TextField(
                controller: subcasteController,
                decoration: InputDecoration(
                  label: Text("Enter your sub-caste"),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ),
              SizedBox(height: 10,),
              Text(
                  "Family Type",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              CustomDropdown(
                  items: familyTypeList,
                  hintText: "Select Family Type",
                  onChanged: (value){
                    selectFamilyType = value!;
                  }
              ),
              SizedBox(height: 10,),
              Text(
                  "Mother Tongue",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              CustomDropdown(
                  items: motherTongue,
                  hintText: "Select Mother Tongue",
                  onChanged: (value){
                    selectMotherTongue = value!;
                  }
              ),
              SizedBox(height: 10,),
              Text(
                  "Diet",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              CustomDropdown(
                  items: dietList,
                  hintText: "Select Diet Type",
                  onChanged: (value){
                    selectDiet = value!;
                  }
              ),
              SizedBox(height: 10,),
              Text(
                  "Marital Status",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              CustomDropdown(
                  items: maritalList,
                  hintText: "Marital Status",
                  onChanged: (value){
                    selectMarital = value!;
                  }
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Educational Qualification",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Highest Qualification",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              SizedBox(height: 10,),
              CustomDropdown.search(
                  items: educationQualification,
                  hintText: "Select Your Highest Qualification",
                  excludeSelected: false,
                  onChanged: (value){
                    setState(() {
                      education = value!;
                    });
                  }
              ),
              SizedBox(height: 10,),
              education == "High School" ? SizedBox() : Text(
                "College",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              education == "High School" ? SizedBox() : SizedBox(height: 10,),
              education == "High School" ? SizedBox() : TextField(
                controller: collegeController,
                decoration: InputDecoration(
                 hintText: "Enter Your College Name",
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20),
                 ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Work Details",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                  "Annual Income",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              SizedBox(height: 10,),
              CustomDropdown.search(
                  items:incomeListINR ,
                  hintText: "Select Annual Income",
                  onChanged: (value){
                    personIncome = value!;
                  }
              ),
              SizedBox(height: 10,),
              Text(
                "Work",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                )
              ),
              SizedBox(height: 10,),
              CustomDropdown(
                  items: worksWithList,
                  hintText: "Select Work",
                  onChanged: (value){
                    setState(() {
                      selectWork = value!;
                    });
                  }
              ),
              SizedBox(height: 10,),
              Text(
                "Work Role",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              SizedBox(height: 10,),
              DropdownButton2<String>(
                value: selectWorkRole,
                    hint: Text("Select Work Role"),
                    isExpanded: true,
                      items: [
                        const DropdownMenuItem(
                          enabled: false,
                            child:Text(
                             "Business & Finance",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Colors.grey
                             ),
                            )
                        ),
                        ...businessRole.map((role)=>DropdownMenuItem(
                          value: role,
                            child: Text(role,overflow: TextOverflow.ellipsis,),
                        )),

                        const DropdownMenuItem(
                            enabled: false,
                            child: Text("IT & Software",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                        ),
                        ...itRoles.map((role)=>DropdownMenuItem(value: role,child: Text(role,overflow: TextOverflow.ellipsis,),)),

                        const DropdownMenuItem(
                          enabled: false,
                            child: Text("Government & Public Sector",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)
                        ),
                        ...governmentJobsListRevised.map((role)=>DropdownMenuItem(value: role,child: Text(role,overflow: TextOverflow.ellipsis,),)),
                      ],
                    onChanged: (value){
                        setState(() {
                          selectWorkRole = value!;
                        });
                    },
                  ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        GestureDetector(
          onTap: ()async{
            await AuthController().updateProfile(
                id: user.id,
                dob: datePickerController.text,
                height: '',
                weight: '',
                marital_status: selectMarital,
                state: selectState,
                city: cityController.text,
                address: addressController.text,
                religion: selectReligion,
                caste: selectCaste,
                subcaste: subcasteController.text,
                mother_tongue: selectMotherTongue,
                gender:selectGender! ,
                education: "${education} from ${collegeController.text}",
                work: selectWork,
                workRole: selectWorkRole!,
                annual_income: personIncome,
                diet: selectDiet,
                family_type: selectFamilyType,
                phone:'' ,
                image: '',
                ref: ref,
                context: context
            );
          },
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Colors.cyan,
                  Colors.cyanAccent
                ])
              ),
              child:Center(
                  child: Text(
                "Create Profile",
                style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),)) ,
            ),
          ),
        ),

        SizedBox(height: 250,)
      ],
    );
  }
}




