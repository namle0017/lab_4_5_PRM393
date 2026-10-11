import 'package:flutter/material.dart';

/// Exercise 2 – Input Widgets: Slider, Switch, RadioListTile, DatePicker
/// Goal: Build interactive UI that lets users control values and display updated state.
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // 1. Slider value (e.g., ticket quantity or volume)
  double _volumeLevel = 50.0;

  // 2. Switch value (e.g., notification / sound toggle)
  bool _receiveNotifications = true;

  // 3. RadioListTile group value (e.g., seat type selection)
  String _seatTier = 'Standard';

  // 4. DatePicker value
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ex 2: Input Controls'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Status Summary Dashboard
            Card(
              color: theme.colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dashboard_customize_rounded, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Live State Values',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Text('• Slider Value: ${_volumeLevel.toStringAsFixed(1)} / 100'),
                    Text('• Notifications: ${_receiveNotifications ? "Enabled (ON)" : "Disabled (OFF)"}'),
                    Text('• Seat Tier: $_seatTier'),
                    Text('• Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // 1. Slider
            Text(
              '1. Slider Control (Volume/Brightness)',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.volume_down),
                Expanded(
                  child: Slider(
                    value: _volumeLevel,
                    min: 0.0,
                    max: 100.0,
                    divisions: 100,
                    label: _volumeLevel.round().toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _volumeLevel = newValue;
                      });
                    },
                  ),
                ),
                const Icon(Icons.volume_up),
              ],
            ),
            const SizedBox(height: 16.0),

            // 2. Switch
            Text(
              '2. Switch Control',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Enable Push Notifications'),
              subtitle: const Text('Receive latest movie updates and showtime alerts'),
              value: _receiveNotifications,
              onChanged: (bool value) {
                setState(() {
                  _receiveNotifications = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // 3. RadioListTile Group
            Text(
              '3. RadioListTile Group (Seat Category)',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Card(
              elevation: 1,
              child: RadioGroup<String>(
                groupValue: _seatTier,
                onChanged: (String? value) {
                  if (value != null) setState(() => _seatTier = value);
                },
                child: const Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Standard Seat'),
                      subtitle: Text('Regular comfortable theatre seating'),
                      value: 'Standard',
                    ),
                    RadioListTile<String>(
                      title: Text('VIP Lounge'),
                      subtitle: Text('Reclining leather seats + free popcorn'),
                      value: 'VIP Lounge',
                    ),
                    RadioListTile<String>(
                      title: Text('IMAX 3D Prime'),
                      subtitle: Text('Full immersive laser audio & screen'),
                      value: 'IMAX 3D Prime',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // 4. DatePicker Button
            Text(
              '4. Date Picker Dialog',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton.icon(
              onPressed: () => _pickDate(context),
              icon: const Icon(Icons.calendar_month_rounded),
              label: Text(
                'Pick Booking Date (${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year})',
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
