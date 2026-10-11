import 'package:flutter/material.dart';

/// Exercise 5 – Debug & Fix Common UI Errors
/// Demonstrates and explains the 4 common UI errors and their proper fixes:
/// 1. ListView inside Column -> Fix with Expanded
/// 2. Overflow on small screens -> Fix with SingleChildScrollView
/// 3. State update not reflecting -> Fix with setState()
/// 4. DatePicker BuildContext errors -> Fix by using valid widget tree context
class CommonErrorsFixDemo extends StatefulWidget {
  const CommonErrorsFixDemo({super.key});

  @override
  State<CommonErrorsFixDemo> createState() => _CommonErrorsFixDemoState();
}

class _CommonErrorsFixDemoState extends State<CommonErrorsFixDemo> {
  // State demonstration variable
  int _counter = 0;
  DateTime? _pickedDate;

  // Track active tab/expansion for each error
  int _activeBugIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ex 5: Debug & Fix UI Errors'),
      ),
      body: SingleChildScrollView(
        // Fix 2 in action: Prevents RenderFlex overflow on small screens / keyboard popup!
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lab 4 - Exercise 5: Debugging Lab',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Interactive analysis and fixes for the 4 most common Flutter UI errors.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),

            // Selector tabs for 4 bugs
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('1. Expanded')),
                ButtonSegment(value: 1, label: Text('2. Overflow')),
                ButtonSegment(value: 2, label: Text('3. setState')),
                ButtonSegment(value: 3, label: Text('4. DatePicker')),
              ],
              selected: {_activeBugIndex},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _activeBugIndex = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 20),

            // Content corresponding to selected bug fix
            if (_activeBugIndex == 0) _buildBug1ExpandedFix(theme),
            if (_activeBugIndex == 1) _buildBug2OverflowFix(theme),
            if (_activeBugIndex == 2) _buildBug3SetStateFix(theme),
            if (_activeBugIndex == 3) _buildBug4DatePickerContextFix(theme),
          ],
        ),
      ),
    );
  }

  /// Task 1: Fix ListView inside Column using Expanded
  Widget _buildBug1ExpandedFix(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Bug 1: ListView inside Column (Unbounded Height)',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text(
              '❌ The Problem:\n'
              'Placing a ListView directly inside a Column throws:\n'
              '"Vertical viewport was given unbounded height."\n'
              'Because both Column and ListView try to expand infinitely in vertical axis.',
              style: TextStyle(color: Colors.redAccent, height: 1.4),
            ),
            const SizedBox(height: 12),
            const Text(
              '✅ The Fix:\n'
              'Wrap the ListView with Expanded (or Flexible / shrinkWrap: true) so it knows how much vertical space to take within the Column.',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text('Live Fixed Example (ListView inside a 180px Column):'),
            const SizedBox(height: 8),
            Container(
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: theme.colorScheme.primaryContainer,
                    child: const Text('Header inside Column', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  // FIX APPLIED HERE: Expanded around ListView
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, idx) => ListTile(
                        dense: true,
                        leading: CircleAvatar(child: Text('${idx + 1}')),
                        title: Text('List Item ${idx + 1} with Expanded'),
                        subtitle: const Text('Scrolls smoothly without unbounded height crash'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Task 2: Fix overflow in small screens using SingleChildScrollView
  Widget _buildBug2OverflowFix(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Bug 2: RenderFlex Overflowed by N Pixels',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text(
              '❌ The Problem:\n'
              'When many widgets are placed inside a fixed Column on smaller phone screens or when virtual keyboard appears, it causes yellow-and-black striped "A RenderFlex overflowed by xxx pixels" warning.',
              style: TextStyle(color: Colors.redAccent, height: 1.4),
            ),
            const SizedBox(height: 12),
            const Text(
              '✅ The Fix:\n'
              'Wrap the outer Column in a SingleChildScrollView (or use ListView). This makes the content scrollable on any screen size or orientation.',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Notice this entire Ex 5 screen is wrapped in SingleChildScrollView, preventing any overflow when viewing all cards!',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Task 3: Fix state update issue by adding setState()
  Widget _buildBug3SetStateFix(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.sync_problem_rounded, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Bug 3: State Not Updating UI (Missing setState)',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text(
              '❌ The Problem:\n'
              'Mutating variable `_counter++` without calling `setState()` updates the internal memory value, but Flutter does not trigger `build()`, so the screen appears unresponsive.',
              style: TextStyle(color: Colors.redAccent, height: 1.4),
            ),
            const SizedBox(height: 12),
            const Text(
              '✅ The Fix:\n'
              'Always wrap mutations inside `setState(() { _counter++; })` in a StatefulWidget so Flutter schedules a re-render of the widget tree.',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Live Counter Value: $_counter',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Increment (with setState)'),
                        onPressed: () {
                          // FIX APPLIED HERE: setState notifies Flutter to redraw!
                          setState(() {
                            _counter++;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _counter = 0;
                          });
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Task 4: Fix DatePicker build context errors
  Widget _buildBug4DatePickerContextFix(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.date_range_rounded, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Bug 4: DatePicker BuildContext Error',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text(
              '❌ The Problem:\n'
              'Calling `showDatePicker(context: ...)` using a stale, disposed context, or calling it outside the active Navigator widget tree throws:\n'
              '"Navigator operation requested with a context that does not include a Navigator."',
              style: TextStyle(color: Colors.redAccent, height: 1.4),
            ),
            const SizedBox(height: 12),
            const Text(
              '✅ The Fix:\n'
              'Call `showDatePicker` from an active widget tree where `BuildContext` contains a valid `Navigator` ancestor, or check `if (!mounted) return;` after async operations before using `context`.',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.event_available),
              label: Text(
                _pickedDate == null
                    ? 'Test Valid DatePicker Context'
                    : 'Selected: ${_pickedDate!.day}/${_pickedDate!.month}/${_pickedDate!.year}',
              ),
              onPressed: () async {
                // FIX APPLIED HERE: Using valid BuildContext from active widget
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _pickedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null && mounted) {
                  setState(() {
                    _pickedDate = picked;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
