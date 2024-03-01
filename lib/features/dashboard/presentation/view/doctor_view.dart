import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorConsultPage extends StatefulWidget {
  const DoctorConsultPage({Key? key}) : super(key: key);

  @override
  _DoctorConsultPageState createState() => _DoctorConsultPageState();
}

class _DoctorConsultPageState extends State<DoctorConsultPage> {
  final TextEditingController msgController = TextEditingController();
  String code = '+977';
  String phone = "9807960408";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Dr. Asmita, MD",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Gynecologist",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "MBBS, MD in Gynecology, Fellowship in Reproductive Medicine",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Consult with Dr. Jane about your health concerns in a private and supportive environment.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: msgController,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: "Your Message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _launchWhatsApp,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Send WhatsApp Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp() async {
    final String message = Uri.encodeComponent(msgController.text);
    final String phoneNumber = code + phone;
    final String url = "https://wa.me/$phoneNumber?text=$message";

    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text(
              "We are redirecting you to WhatsApp, do you want to continue?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm ?? false) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Fluttertoast.showToast(msg: "Could not launch WhatsApp");
      }
    }
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }
}
