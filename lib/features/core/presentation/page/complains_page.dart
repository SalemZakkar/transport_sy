import 'package:flutter/material.dart';
import 'package:core_package/core_package.dart';

class ComplainsPage extends StatelessWidget {
  static String path = "/ComplainsPage";

  const ComplainsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> complains = [
      {
        "line": "خط الوعر",
        "date": "2023-10-25",
        "busNumber": "123456",
        "description": "السائق لم يتوقف في المحطة المحددة وكان يسير بسرعة عالية.",
        "status": "pending",
        "adminNotes": ""
      },
      {
        "line": "خط طريق الشام",
        "date": "2023-10-20",
        "busNumber": "654321",
        "description": "تأخر الباص عن موعده لأكثر من نصف ساعة.",
        "status": "accepted",
        "adminNotes": "تم التحقق من سجلات الباص وتنبيه السائق."
      },
      {
        "line": "خط حي الأرمن",
        "date": "2023-10-15",
        "busNumber": "112233",
        "description": "المقاعد غير نظيفة ومتهالكة.",
        "status": "rejected",
        "adminNotes": "تم فحص الباص والمقاعد بحالة جيدة حالياً."
      },
      {
        "line": "خط الزهراء",
        "date": "2023-10-10",
        "busNumber": "445566",
        "description": "سوء معاملة من قبل الجابي.",
        "status": "accepted",
        "adminNotes": "تم اتخاذ الإجراءات اللازمة بحق الموظف."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("الشكاوي"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: complains.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final complain = complains[index];
          return _ComplaintCard(complain: complain);
        },
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complain;

  const _ComplaintCard({required this.complain});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;

    switch (complain['status']) {
      case 'accepted':
        statusColor = Colors.green;
        statusText = "مقبولة";
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusText = "مرفوضة";
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
        statusText = "قيد المعالجة";
        break;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  complain['line'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  complain['date'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(width: 16),
                Icon(Icons.directions_bus, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  "باص رقم: ${complain['busNumber']}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              "الوصف:",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(complain['description']),
            if (complain['status'] != 'pending' && complain['adminNotes'].isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ملاحظات الإدارة:",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      complain['adminNotes'],
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
