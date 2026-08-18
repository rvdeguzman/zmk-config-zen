# Wait for the GitHub Actions build of the current commit, then drop the .uf2 files in out/
firmware:
	@run=""; until [ -n "$$run" ]; do \
	  run=$$(gh run list -c $$(git rev-parse HEAD) -L1 --json databaseId -q '.[0].databaseId'); \
	  [ -n "$$run" ] || { echo "waiting for run on $$(git rev-parse --short HEAD)..."; sleep 5; }; \
	done; \
	gh run watch $$run --exit-status && rm -rf out && gh run download $$run -n firmware -D out && ls out
