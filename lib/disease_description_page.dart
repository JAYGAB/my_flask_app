import 'package:flutter/material.dart';

class DiseaseDescriptionPage extends StatelessWidget {
  final String diseaseName;

  DiseaseDescriptionPage({required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/DecPage_bg.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with scrollable description
          Column(
            children: [
              // Custom AppBar
              PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: AppBar(
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 255, 255)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      diseaseName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: const Color(0x00000000), // Make the AppBar transparent
                ),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      Text(
                        _getDiseaseDescription(diseaseName),
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 250, 250, 250),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Causes:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 246, 246, 246),
                          ),
                        ),
                      ),
                      Text(
                        _getDiseaseCauses(diseaseName),
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Treatment:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      Text(
                        _getDiseaseTreatment(diseaseName),
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDiseaseDescription(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'mold':
        return 'Mold is a fungal disease that can affect a wide range of plants, including vegetables, ornamentals, and even trees.';
      case 'late blight':
        return 'Late blight is a destructive disease of tomatoes and potatoes that can kill mature plants, and make tomato fruits and potato tubers inedible.';
      case 'septoria':
        return 'Septoria is one of two common fungal diseases that can devastate both commercial settings and home gardens.';
      case 'early blight':
        return 'Early blight is a fungal pathogen of tomatoes that also affects plants like peppers, potatoes, eggplants, and other members of the nightshade family.';
      case 'mosaic virus':
        return 'Mosaic virus is characterized by leaves mottled with yellow, white, and light or dark green spots and streaks, forming a mosaic of colors.';
      case 'target spot':
        return 'Target spot refers to a variety of fungal and bacterial infections that cause discolored lesions or spots on the leaves of affected plants.';
      case 'spider mite':
        return 'Spider mites are tiny arachnids that feed on plant sap, causing stippling (tiny yellow or white spots) on leaves.';
      case 'bacterial spot':
        return 'Bacterial spot is a plant disease caused by bacteria that affects the leaves of plants, causing small, water-soaked spots that eventually turn brown and necrotic.';
      case 'healthy':
        return 'This term refers to the absence of any disease symptoms in plants.';
      case 'yellow leaf curl virus':
        return 'Yellow leaf curl virus is a viral disease of tomato that has limited distribution but can cause devastating losses once established.';
      default:
        return 'No description available.';
    }
  }

  String _getDiseaseCauses(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'mold':
        return 'Excessive moisture, poor air circulation, and overcrowding of plants.';
      case 'late blight':
        return 'Caused by the water mold Phytophthora infestans. The disease occurs in humid regions with temperatures ranging between 4 and 29 °C (40 and 80 °F).';
      case 'septoria':
        return 'Caused by the fungus Septoria lycopersici, which survives in plant debris or on infected plants.';
      case 'early blight':
        return 'Caused by the fungus Alternaria tomatophila and Alternaria solani, two different species but of the same genus.';
      case 'mosaic virus':
        return 'Spread by aphids and other insects, mites, fungi, nematodes, and contact; pollen and seeds can carry the infection as well.';
      case 'target spot':
        return 'Primarily caused by pathogenic fungi, though some are caused by bacteria.';
      case 'spider mite':
        return 'Spider mites infest plants due to environmental stress, drought, or high temperatures.';
      case 'bacterial spot':
        return 'Caused by bacterial pathogens, such as Xanthomonas campestris or Pseudomonas syringae, which infect the leaves of plants.';
      case 'healthy':
        return 'Proper care, good nutrition, and disease prevention practices contribute to plant health.';
      case 'yellow leaf curl virus':
        return 'External stress (temperature or watering issues), non-parasitic leaf roll (irregular irrigation/bad pruning), herbicides, broad mites.';
      default:
        return 'No causes available.';
    }
  }

  String _getDiseaseTreatment(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'mold':
        return 'Proper site selection, adequate spacing between plants, appropriate watering practices, and removing and disposing of infected plant parts.';
      case 'late blight':
        return 'Affected plants cannot be saved and should be disposed of immediately to limit the spread of P. infestans.';
      case 'septoria':
        return 'Thinning of whole plants or removal of selected branches may slow the disease by increasing airflow and reducing humidity. Fungicides may also provide control.';
      case 'early blight':
        return 'Cultural methods such as irrigating below, pruning plants, and removing infected tissues early are most effective for home gardeners.';
      case 'mosaic virus':
        return 'There is no cure for mosaic viruses. Prevention is key. Remove and destroy infected plants and avoid composting them.';
      case 'target spot':
        return 'Proper spacing, watering, sanitation, and crop rotation.';
      case 'spider mite':
        return 'Keep plants healthy, avoid overcrowding, monitor for signs of infestation, use natural predators like ladybugs, and maintain a favorable environment.';
      case 'bacterial spot':
        return 'Provide good air circulation, avoid overhead watering, and practice crop rotation.';
      case 'healthy':
        return 'Maintain optimal growing conditions and promptly address any issues.';
      case 'yellow leaf curl virus':
        return 'Rotate with non-host crops, monitor the whitefly population, remove infected plants, and avoid planting unhealthy transplants.';
      default:
        return 'No treatment available.';
    }
  }
}

