import 'package:flutter/material.dart';

class FiltersItem extends StatelessWidget {
  final bool _value;
  final ValueChanged<bool> _onChanged;
  final String _title;
  final String _subTitle;

  const FiltersItem(
    this._value,
    this._onChanged,
    this._title,
    this._subTitle, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _value,
      onChanged: _onChanged,
      title: Text(
        _title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        _subTitle,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
