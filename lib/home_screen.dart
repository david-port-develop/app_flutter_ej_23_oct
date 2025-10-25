import 'package:flutter/material.dart';
import '/models/country_model.dart';
import '/models/user_model.dart';
import '/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<User>> _usersFuture;
  late Future<List<Country>> _countriesFuture;

  @override
  void initState() {
    super.initState();
    // Iniciamos las llamadas a la API aquí.
    _usersFuture = _apiService.fetchUsers();
    _countriesFuture = _apiService.fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Datos de APIs'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Usuarios'),
              Tab(icon: Icon(Icons.flag), text: 'Países'),
            ],
          ),
        ),
        body: TabBarView(children: [_buildUsersList(), _buildCountriesList()]),
      ),
    );
  }

  Widget _buildUsersList() {
    return FutureBuilder<List<User>>(
      future: _usersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No se encontraron usuarios.'));
        }

        final users = snapshot.data!;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(child: Text(user.id.toString())),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(user.email),
            );
          },
        );
      },
    );
  }

  Widget _buildCountriesList() {
    return FutureBuilder<List<Country>>(
      future: _countriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No se encontraron países.'));
        }

        final countries = snapshot.data!;
        return ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];
            return ListTile(
              leading: const Icon(Icons.public),
              title: Text(country.name),
              subtitle: Text('Capital: ${country.capital}'),
            );
          },
        );
      },
    );
  }
}
