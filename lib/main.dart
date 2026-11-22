
import 'package:material_ui/material_ui.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) => double.tryParse(input.trim());

({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController billController =
      TextEditingController();

  int selectedPercent = 15;

  @override
  void dispose() {
    billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(billController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Enter Bill Amount'),

            TextField(
              controller: billController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter bill amount',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(height: 20),

            const Text('Select Tip Percentage'),

            const SizedBox(height: 10),

            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 10, label: Text('10%')),
                ButtonSegment(value: 15, label: Text('15%')),
                ButtonSegment(value: 20, label: Text('20%')),
              ],
              selected: {selectedPercent},
              onSelectionChanged: (selection) {
                setState(() {
                  selectedPercent = selection.first;
                });
              },
            ),

            const SizedBox(height: 25),

            if (bill == null || bill < 0)
              const Text('Enter a valid amount')
            else ...[
              Builder(
                builder: (context) {
                  final result = computeTip(bill, selectedPercent);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tip: ${result.tip.toStringAsFixed(2)}',
                      ),
                      Text(
                        'Total: ${result.total.toStringAsFixed(2)}',
                      ),
                    ],
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
