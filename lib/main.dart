import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const CvPortfolioApp());

const navy = Color(0xFF243B53);
const orange = Color.fromARGB(255, 23, 33, 142);
const pale = Color(0xFFF3F6FA);

class CvPortfolioApp extends StatelessWidget {
  const CvPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV - MWIZA SERUGARI GLORIA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: navy, primary: navy),
        scaffoldBackgroundColor: const Color.fromARGB(255, 12, 68, 140),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 129, 63, 180),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _user = TextEditingController();
  final _password = TextEditingController();
  bool _hidePassword = true;

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    // Identifiants de démonstration : eugene / 1234
    if (_user.text.trim().toLowerCase() == 'eugene' &&
        _password.text == '1234') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Identifiant ou mot de passe incorrect.')),
      );
    }
  }

  @override
  void dispose() {
    _user.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 42,
                        backgroundColor: navy,
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Bienvenue',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Connectez-vous pour consulter mon portfolio',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 26),
                      TextFormField(
                        controller: _user,
                        decoration: const InputDecoration(
                          labelText: 'Identifiant',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Saisissez votre identifiant'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _password,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => _hidePassword = !_hidePassword),
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Saisissez votre mot de passe'
                            : null,
                        onFieldSubmitted: (_) => _login(),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: orange,
                          ),
                          onPressed: _login,
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Démo :  gloria /  1234',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  final _pages = const [HomePage(), FamilyPage(), ContactPage()];
  final _titles = const ['Mon CV', 'Ma famille', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      drawer: NavigationDrawer(
        selectedIndex: _index,
        onDestinationSelected: (i) {
          Navigator.pop(context);
          setState(() => _index = i);
        },
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 92, 41, 147),
                  child: Icon(Icons.person, color: Colors.white, size: 34),
                ),
                SizedBox(height: 10),
                Text(
                  'MWIZA SERUGARI GLORIA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Portfolio personnel'),
              ],
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.badge_outlined),
            label: Text('Mon CV'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.family_restroom),
            label: Text('Ma famille'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.contact_mail_outlined),
            label: Text('Contact'),
          ),
        ],
      ),
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.badge_outlined), label: 'CV'),
          NavigationDestination(
            icon: Icon(Icons.family_restroom),
            label: 'Famille',
          ),
          NavigationDestination(
            icon: Icon(Icons.mail_outline),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [navy, Color(0xFF496783)]),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 66, color: navy),
                ),
                SizedBox(height: 14),
                Text(
                  'MWIZA SERUGARI GLORIA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Étudiant en Sciences informatiques',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  'Réseaux et Télécommunications',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        const InfoSection(
          title: 'INFORMATIONS PERSONNELLES',
          icon: Icons.person,
          children: [
            InfoLine('Lieu de naissance', 'GOMA'),
            InfoLine('Date de naissance', '28/10/2006'),
            InfoLine('État civil', 'Célibataire'),
            InfoLine('Nationalité', 'Congolaise'),
          ],
        ),
        const InfoSection(
          title: 'FORMATION',
          icon: Icons.school,
          children: [
            InfoLine(
              '2024 – aujourd’hui',
              'ISIG-GOMA – Sciences informatiques (Réseaux et Télécommunications)',
            ),
            InfoLine(
              '2018 – 2023',
              'Institut Munyembelu, Beni – Diplôme d’État en électronique',
            ),
            InfoLine(
              '2012 – 2017',
              'EP Butanuka, Beni – Certificat de fin d’études primaires',
            ),
          ],
        ),
        const InfoSection(
          title: 'EXPÉRIENCES PROFESSIONNELLES',
          icon: Icons.work,
          children: [
            InfoLine('2020 – aujourd’hui', 'Maintenancier électronicien'),
            InfoLine('2022 – aujourd’hui', 'Maintenancier électricien'),
            InfoLine('2024 – aujourd’hui', 'Informaticien'),
          ],
        ),
        const InfoSection(
          title: 'COMPÉTENCES TECHNIQUES',
          icon: Icons.computer,
          children: [
            InfoLine(
              'Domaines',
              'Électronique, électricité, réseaux informatiques et bureautique',
            ),
            InfoLine(
              'Formations complémentaires',
              'Administration réseau, administration de bases de données, télécommunication (en cours)',
            ),
          ],
        ),
        const InfoSection(
          title: 'LANGUES',
          icon: Icons.translate,
          children: [
            InfoLine('Kiswahili', 'Très bien'),
            InfoLine('Français', 'Très bien'),
            InfoLine('Anglais', 'Niveau fonctionnel'),
          ],
        ),
        const InfoSection(
          title: 'CENTRES D’INTÉRÊT',
          icon: Icons.favorite,
          children: [Text('PlayStation • Sport • Musique')],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });
  final String title;
  final IconData icon;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(top: 12),
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: orange),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: navy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 22),
          ...children.map(
            (w) => Padding(padding: const EdgeInsets.only(bottom: 9), child: w),
          ),
        ],
      ),
    ),
  );
}

class InfoLine extends StatelessWidget {
  const InfoLine(this.label, this.value, {super.key});
  final String label, value;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, color: navy),
      ),
      const SizedBox(height: 2),
      Text(value, style: const TextStyle(height: 1.35)),
    ],
  );
}

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Les membres ci-dessous proviennent des informations du CV.
    // Ajoutez les photos dans assets/images puis remplacez les icônes si nécessaire.
    const members = [
      _FamilyMember(
        'GLOIRE SERUGARI',
        'Père',
        'Profession à compléter',
        Icons.man,
      ),
      _FamilyMember(
        'SHEKINAH SIFA',
        'Mère',
        'Profession à compléter',
        Icons.woman,
      ),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Les personnes qui composent ma famille',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        const SizedBox(height: 12),
        ...members.map(
          (m) => Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFFE3EAF1),
                child: Icon(m.icon, color: navy, size: 32),
              ),
              title: Text(
                m.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${m.relation}\n${m.profession}'),
              isThreeLine: true,
            ),
          ),
        ),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              'Pour compléter cette page, ajoutez les photos et les informations des autres membres de votre famille.',
            ),
          ),
        ),
      ],
    );
  }
}

class _FamilyMember {
  const _FamilyMember(this.name, this.relation, this.profession, this.icon);
  final String name, relation, profession;
  final IconData icon;
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _open(BuildContext context, Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d’ouvrir cette application.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Restons en contact',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        const SizedBox(height: 14),
        ContactTile(
          icon: Icons.phone,
          label: 'Téléphone',
          value: '+243 982 804 823',
          onTap: () =>
              _open(context, Uri(scheme: 'tel', path: '+243971758416')),
        ),
        ContactTile(
          icon: Icons.chat,
          label: 'WhatsApp',
          value: '+243 982 804 823',
          onTap: () => _open(context, Uri.parse('https://wa.me/982804823')),
        ),
        ContactTile(
          icon: Icons.email,
          label: 'E-mail',
          value: 'serugarigloria28@gmail.com',
          onTap: () => _open(
            context,
            Uri(scheme: 'mailto', path: 'serugarigloria28@gmail.com'),
          ),
        ),
        const ContactTile(
          icon: Icons.location_on,
          label: 'Adresse',
          value: 'MAJENGO, Goma, Nord-Kivu, RDC',
        ),
        const ContactTile(
          icon: Icons.code,
          label: 'GitHub',
          value: 'mwizaserugarigloria',
        ),
        const ContactTile(
          icon: Icons.link,
          label: 'LinkedIn',
          value: 'Mwizaserugarigloria',
        ),
      ],
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });
  final IconData icon;
  final String label, value;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFFFE9D2),
        child: Icon(icon, color: orange),
      ),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, color: navy),
      ),
      subtitle: Text(value),
      trailing: onTap == null ? null : const Icon(Icons.open_in_new, size: 18),
    ),
  );
}
