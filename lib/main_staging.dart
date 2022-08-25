// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:rick_and_morty/app/app.dart';
import 'package:rick_and_morty/bootstrap.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

void main() {
  bootstrap(() => App(rickAndMortyRepository: RickAndMortyRepository()));
}
