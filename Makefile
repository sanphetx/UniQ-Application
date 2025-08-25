prepare:
	@dart pub global activate rps \
	&& rps install \
	&& rps generator build \
	&& rps merge-l10n \
	&& fvm dart run husky install