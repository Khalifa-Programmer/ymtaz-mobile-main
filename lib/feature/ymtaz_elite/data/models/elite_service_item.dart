class EliteServiceItem {
  final String type;
  final String title;
  final double price;
  final Map<String, dynamic> additionalData;

  EliteServiceItem({
    required this.type,
    required this.title,
    required this.price,
    required this.additionalData,
  });

  String getDisplayDetails() {
    switch (type) {
      case 'استشارة':
        return 'تخصص: ${additionalData['specialization'] ?? ''}\nالسعر: $price ريال';
      case 'خدمة':
        return 'خدمة: ${additionalData['serviceName'] ?? ''}\nالسعر: $price ريال';
      case 'موعد':
        return 'نوع: ${additionalData['appointmentType'] ?? ''}\n'
            'التاريخ: ${additionalData['date'] ?? ''}\n'
            'الوقت: ${additionalData['startTime']} - ${additionalData['endTime']}\n'
            'المكان: ${additionalData['location']['address']}\n'
            'السعر: $price ريال';
      default:
        return '';
    }
  }
}
