const fs = require('fs');
const path = require('path');

function processDirMap(dirMapContent, dir) {
  const rootPath = dir; // Current working directory
   const lines = dirMapContent.split('\n');
 
   const rootFolder = {
     type: 'folder',
     name: '.',
     children: [],
   };
 
   let currentFolder = rootFolder;
 
	lines.forEach(line => {
	    const trimmedLine = line.trim();
	
	    if (trimmedLine !== '') {
	      const indentation = line.search(/\S/);
	      const isDirectory = trimmedLine.endsWith('/');
	      const fileName = isDirectory ? trimmedLine.slice(0, -1) : trimmedLine;
	      const item = {
	        type: isDirectory ? 'folder' : 'file',
	        name: fileName,
	      };
		  if(isDirectory) item.children = [];
	      if (indentation === 0) {
	        currentFolder.children.push(item);
	        currentFolder = item;
	      } else {
	        let parent = currentFolder;
	        while (indentation <= parent.indentation) {
	          parent = parent.parent;
	        }
	        parent.children.push(item);
	        item.indentation = indentation;
	        item.parent = parent;
	        currentFolder = item;
	      }
	    }
	  });
	

  createStructure(rootFolder, rootPath);
}

function createStructure(rootFolder, basePath = '') {
  const currentPath = path.join(basePath, rootFolder.name);
  createDirectory(currentPath);

  rootFolder.children.forEach(child => {
    if (child.type === 'folder') {
      createStructure(child, currentPath);
    } else if (child.type === 'file') {
      const filePath = path.join(currentPath, child.name);
      createFile(filePath);
    }
  });
}

function createDirectory(directoryPath) {
  if (!fs.existsSync(directoryPath)) {
    fs.mkdirSync(directoryPath, { recursive: true });
    console.log('Created directory:', directoryPath);
  }
}

function createFile(filePath) {
  if (!fs.existsSync(filePath)) {
    fs.writeFileSync(filePath, '');
    console.log('Created file:', filePath);
  }
}

function findDirmapInDir(dir, exec){
	const dirmap = path.join(dir, '.dirmap');
	if(fs.existsSync(dirmap)){
		const dirmapContent = fs.readFileSync(dirmap).toString();
		if(exec) return processDirMap(dirmapContent, dir);
		return dirmapContent;
	}
}

function recursiveWriteFileSync(filePath) {
  const isFolder = filePath.endsWith('/');

  if (isFolder) {
    // If the path ends with "/", treat it as a folder
    filePath = filePath.slice(0, -1);
    fs.mkdirSync(filePath, { recursive: true });
  } else {
    // If the path is a file, create parent folders and write the content
    const parentDir = path.dirname(filePath);
    fs.mkdirSync(parentDir, { recursive: true });
    fs.writeFileSync(filePath, "");
  }
}

function writeDirMap(dir, map){
	fs.writeFileSync(path.join(dir, '.dirmap'), map);
}

function generateDirMap(dirPath, indent = '') {
  	let result = indent + path.basename(dirPath) + '/\n';
  	if(dirPath.match(/node_modules|.git/)) return;
  
    try {
      const files = fs.readdirSync(dirPath);
  
      files.forEach((file) => {
        const filePath = path.join(dirPath, file);
        const stats = fs.statSync(filePath);

        if(filePath.match('.git') || filePath.match('node_modules')) return;
  
        if (stats.isDirectory()) {
          result += generateDirMap(filePath, indent + '\t');
        } else {
          result += indent + '\t' + file + '\n';
        }
      });
    } catch (err) {
      console.error('Error reading directory:', err);
    }
    return result;
}

// processDirMap(dirMapContent);
var argv = process.argv.slice(2, process.argv.length);

if(argv[0] == 'update'){
	const dirMapCurrent = findDirmapInDir(process.cwd());
	const firstLine = dirMapCurrent.split('\n').shift().split('/')[0];
	writeDirMap(process.cwd(), generateDirMap(path.join(process.cwd(), firstLine)));
} else if(argv.length){
	argv.forEach(pa => {
		const p = path.resolve(pa);
		const dirMapCurrent = findDirmapInDir(process.cwd());
		const firstLine = dirMapCurrent.split('\n').shift().split('/')[0];
		if(fs.existsSync(p)) {
			writeDirMap(process.cwd(), generateDirMap(path.join(process.cwd(), firstLine)));
			return;
		}
		recursiveWriteFileSync(p);
		writeDirMap(process.cwd(), generateDirMap(path.join(process.cwd(), firstLine)));
	});
} else {
	findDirmapInDir(process.cwd(), true);
}
