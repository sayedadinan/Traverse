import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & policy'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Main advantage',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  '''SAYED ADINAN at no cost and is intended for use as is.This page is used to 
inform visitors regarding my policies with the collection, use and disclosure 
 of Personal Information if anyone decided to use my Service. If you choose to 
use my Service, then you agree to the collection and use of information in relationto this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone exceptas described in this Privacy Policy. The terms used in this Privacy Policy have thesame meanings as in our Terms and Conditions, which are accessible at Traverese unless otherwise defined in this Privacy Policy.'''),
              Text(
                'Information Collection and Use',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  '''For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to username,email,password. The information that I request will be retained on your device and is not collected by me in any way. \n The app does use third-party services that may collect information used to identify you. \nLink to the privacy policy of third-party service providers used by the app '''),
              Text(
                'Cookies',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  '''Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.'''),
              Text(
                'Service Providers',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  'I may employ third-party companies and individuals due to the following reasons:'),
              SizedBox(
                height: 15,
              ),
              Text(' •  To facilitate our Service;'),
              SizedBox(
                height: 10,
              ),
              Text(' • To provide the Service on our behalf;'),
              SizedBox(
                height: 10,
              ),
              Text(' •  To perform Service-related services; or'),
              SizedBox(
                height: 10,
              ),
              Text(' •  To assist us in analyzing how our Service is used.'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.'),
              Text(
                'Security',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.'),
              Text(
                'Links to Other Sites',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.'),
              Text(
                'Children’s Privacy',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  'These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.'),
              Text(
                'Changes to This Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. \n This policy is effective as of 2024-01-11'),
              Text(
                'Contact Us',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                  'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at adinansayed@gmail.com. '),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
