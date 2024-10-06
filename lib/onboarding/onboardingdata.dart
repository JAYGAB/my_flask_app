import 'onboardinginfo.dart';

class OnboardingData{


  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Easy Disease Detection",
      desc: "Our advanced AI will quickly diagnose any potential diseases, helping you take immediate action!",
      image: "assets/detect.gif"),

     OnboardingInfo(
      title: "Accurate Predictions",
      desc: "Leverages state-of-the-art Convolutional Neural Networks (CNN) trained on thousands of images to provide precise and reliable disease identification for your leafy vegetables!",
      image: "assets/accurate.gif"),

    OnboardingInfo(
      title: "Save Time",
      desc: "Reduce the time spent on manual inspections, and ensure healthier, higher-quality harvests!",
      image: "assets/time.gif"),
    
  ];
}