<map version="freeplane 1.7.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node TEXT="Yilong_2218" FOLDED="false" ID="ID_818401885" CREATED="1539119408602" MODIFIED="1649946230052"><hook NAME="MapStyle" zoom="1.609">
    <properties show_icon_for_attributes="true" edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" show_note_icons="true" fit_to_viewport="false"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24.0 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ICON_SIZE="12.0 pt" COLOR="#000000" STYLE="fork">
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important">
<icon BUILTIN="yes"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10.0 pt" SHAPE_VERTICAL_MARGIN="10.0 pt">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11"/>
</stylenode>
</stylenode>
</map_styles>
</hook>
<attribute NAME="author" VALUE="Yilong"/>
<attribute NAME="institute" VALUE="MPI_2218"/>
<hook NAME="presentations">
    <presentation NAME="Nov&#xe1; prezent&#xe1;cia 1">
        <slide NAME="Nov&#xfd; sn&#xed;mok 1"/>
    </presentation>
</hook>
<node TEXT="1. DE genes &amp; transcripts" POSITION="right" ID="ID_379090753" CREATED="1539242363764" MODIFIED="1649949970391" BACKGROUND_COLOR="#ffffff" NUMBERED="true" HGAP_QUANTITY="19.99999982118607 pt" VSHIFT_QUANTITY="145.49999566376223 pt">
<font BOLD="false"/>
<edge STYLE="sharp_bezier" COLOR="#000099" WIDTH="2"/>
<richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      &quot;/data/processing1/bioinfo_core/requests/FANCI_RNA_seq_4stresses/&quot;
    </p>
  </body>
</html>
</richcontent>
<node TEXT="DE genes" ID="ID_1624758610" CREATED="1539243173801" MODIFIED="1649938549858"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      featureCounts + DESeq2
    </p>
  </body>
</html>
</richcontent>
<node TEXT="gene_level (alignment mode)" ID="ID_339150267" CREATED="1539242451835" MODIFIED="1649936873880">
<node TEXT="totalRNA" ID="ID_1750383800" CREATED="1650092528750" MODIFIED="1650092532443"/>
<node TEXT="SG" ID="ID_804292648" CREATED="1650092533580" MODIFIED="1650092535227"/>
</node>
<node TEXT="gene_level_batch (alignment mode)" ID="ID_713359816" CREATED="1649936893374" MODIFIED="1649936904889">
<node TEXT="SG_batch" ID="ID_1866297572" CREATED="1649943071115" MODIFIED="1650275046178" BACKGROUND_COLOR="#ffffff"/>
<node TEXT="totalRNA_batch" ID="ID_876178165" CREATED="1650092538606" MODIFIED="1650116515435"/>
</node>
</node>
<node TEXT="DE transcripts" ID="ID_807687589" CREATED="1539195518043" MODIFIED="1649938568149" VSHIFT_QUANTITY="22.499999329447768 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Salmon + Sleuth
    </p>
  </body>
</html>
</richcontent>
<node TEXT="transcript_level (alignment_free mode)" ID="ID_394288053" CREATED="1539207718673" MODIFIED="1650225424586" BACKGROUND_COLOR="#ffffff"><richcontent TYPE="NOTE">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Lorem ipsum
    </p>
  </body>
</html>
</richcontent>
<node TEXT="totalRNA" ID="ID_1095854143" CREATED="1650092498043" MODIFIED="1650092504659"/>
<node TEXT="SG" ID="ID_1045846271" CREATED="1650092505181" MODIFIED="1650092510173"/>
</node>
<node TEXT="transcript_level_batch (alignment_free mode)" ID="ID_481261550" CREATED="1540770546194" MODIFIED="1650225431008" BACKGROUND_COLOR="#ffffff">
<node TEXT="SG_batch" ID="ID_1321257641" CREATED="1649943120279" MODIFIED="1650275053543" BACKGROUND_COLOR="#ffffff"/>
<node TEXT="totalRNA_batch" ID="ID_740572196" CREATED="1650092513359" MODIFIED="1650275089816">
<node TEXT="compare sleuth nr with DESeq2 nr from same folder" ID="ID_675131925" CREATED="1650275105190" MODIFIED="1650275128288" BACKGROUND_COLOR="#ff3333">
<node TEXT="NEXT" ID="ID_1102431511" CREATED="1651042176276" MODIFIED="1651042179315"/>
</node>
</node>
</node>
</node>
<node TEXT="ask Thomas about unbalanced experimental design" ID="ID_1950367511" CREATED="1649942939329" MODIFIED="1649942988827" HGAP_QUANTITY="13.250000022351742 pt" VSHIFT_QUANTITY="19.49999941885473 pt" BACKGROUND_COLOR="#ff3333">
<node TEXT="go on with batch modeled in for DESeq2 analysis" ID="ID_392471615" CREATED="1650989739900" MODIFIED="1650989760220"/>
</node>
<node TEXT="explanation for DE transcript vs DE gene" ID="ID_1204159018" CREATED="1649943016310" MODIFIED="1649945267760" BACKGROUND_COLOR="#ff6666"/>
<node TEXT="DE overall genes and transcripts, new PCAs for batch-accounted counts" ID="ID_176769850" CREATED="1649945269523" MODIFIED="1649945308334" BACKGROUND_COLOR="#ff3333"/>
</node>
<node TEXT="DE splicing analysis" POSITION="right" ID="ID_1506292083" CREATED="1649938668448" MODIFIED="1649946216810" HGAP_QUANTITY="45.49999906122687 pt" VSHIFT_QUANTITY="152.24999546259656 pt" BACKGROUND_COLOR="#999999"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      rMats-turbo
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="Intronic RNA analysis" POSITION="right" ID="ID_224691216" CREATED="1649945431162" MODIFIED="1649946220053" BACKGROUND_COLOR="#999999" HGAP_QUANTITY="46.24999903887513 pt" VSHIFT_QUANTITY="86.24999742954977 pt">
<node TEXT="what intronic RNA are increased in UV granules" ID="ID_231767456" CREATED="1649945450745" MODIFIED="1649945469271"/>
<node TEXT="what is the feature of these enriched intronic RNA" ID="ID_1671108373" CREATED="1649945469689" MODIFIED="1649945482220"/>
<node TEXT="needed to do FISH validation" ID="ID_1077921281" CREATED="1649945482756" MODIFIED="1649945489407"/>
</node>
<node TEXT="multimapped/ unmapped reads" FOLDED="true" POSITION="right" ID="ID_229032011" CREATED="1649942776439" MODIFIED="1649944951102" HGAP_QUANTITY="44.749999083578615 pt" VSHIFT_QUANTITY="124.49999628961098 pt" BACKGROUND_COLOR="#999999">
<font BOLD="false"/>
<node TEXT="where do they come from? what are they?" ID="ID_1658892207" CREATED="1649942923816" MODIFIED="1649942933620"/>
</node>
<node TEXT="2. circular RNAs" POSITION="right" ID="ID_611283573" CREATED="1539119421899" MODIFIED="1651494685887" BACKGROUND_COLOR="#ffffff" NUMBERED="true" HGAP_QUANTITY="14.000000000000004 pt" VSHIFT_QUANTITY="-88.49999736249458 pt">
<font BOLD="false"/>
<edge STYLE="sharp_bezier" COLOR="#000099" WIDTH="2"/>
<richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      '/data/processing3/balan/projects/2218_Yilong_part2'
    </p>
  </body>
</html>
</richcontent>
<node TEXT="ID circRNAs" ID="ID_771250234" CREATED="1539119553321" MODIFIED="1651494685886" HGAP_QUANTITY="17.749999888241295 pt" VSHIFT_QUANTITY="-2.2499999329447764 pt">
<node TEXT="CIRI_pipeline (CIRI2 + CIRI_AS + CIRI_full)" ID="ID_1864503137" CREATED="1539243305536" MODIFIED="1649946247217" HGAP_QUANTITY="16.999999910593036 pt" VSHIFT_QUANTITY="-40.49999879300598 pt">
<node TEXT="CIRI2 (&gt; .ciri)" ID="ID_1382318278" CREATED="1539248993283" MODIFIED="1649770327343" HGAP_QUANTITY="20.74999979883433 pt" VSHIFT_QUANTITY="-39.74999881535772 pt">
<arrowlink SHAPE="LINE" COLOR="#999999" WIDTH="2" TRANSPARENCY="200" DASH="7 7" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_1810045228" STARTINCLINATION="-31;33;" ENDINCLINATION="-93;-32;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="CIRI_AS (&gt; _jav.list)" ID="ID_1810045228" CREATED="1540771505519" MODIFIED="1651493084947" HGAP_QUANTITY="19.24999984353781 pt" VSHIFT_QUANTITY="-28.499999150633837 pt" BACKGROUND_COLOR="#ffcccc">
<arrowlink SHAPE="LINE" COLOR="#999999" WIDTH="2" TRANSPARENCY="200" DASH="7 7" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_1945811036" STARTINCLINATION="11;42;" ENDINCLINATION="-99;-13;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="CIRI_full (&gt; _merge_circRNA_detail.anno)" ID="ID_1945811036" CREATED="1649769953181" MODIFIED="1649938417103" HGAP_QUANTITY="19.24999984353781 pt" VSHIFT_QUANTITY="0.7499999776482589 pt">
<arrowlink SHAPE="LINE" COLOR="#999999" WIDTH="2" TRANSPARENCY="200" DASH="7 7" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_497134942" STARTINCLINATION="-18;-16;" ENDINCLINATION="13;-17;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
</node>
<node TEXT="CIRCexplorer2" ID="ID_920760343" CREATED="1539249107860" MODIFIED="1651494699657" HGAP_QUANTITY="15.499999955296516 pt" VSHIFT_QUANTITY="41.24999877065424 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      &quot;/analysis_circRNAprofiler/&quot;
    </p>
  </body>
</html>
</richcontent>
<node TEXT="manual align: STAR, bwa" ID="ID_1171929684" CREATED="1649843574886" MODIFIED="1651494696547" HGAP_QUANTITY="5.750000245869156 pt" VSHIFT_QUANTITY="-44.999998658895535 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      &quot;/*_align/&quot;
    </p>
  </body>
</html>
</richcontent>
<node TEXT="STAR &gt; *Chimeric.out.junction" ID="ID_1303695694" CREATED="1649843870741" MODIFIED="1649944156083" HGAP_QUANTITY="9.500000134110447 pt" VSHIFT_QUANTITY="-19.49999941885473 pt">
<arrowlink SHAPE="LINE" COLOR="#999999" WIDTH="2" TRANSPARENCY="200" DASH="7 7" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_1406976541" STARTINCLINATION="141;50;" ENDINCLINATION="117;-57;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="bwa &gt; *.sam" ID="ID_1458717957" CREATED="1649843903649" MODIFIED="1649845114153" HGAP_QUANTITY="15.499999955296518 pt" VSHIFT_QUANTITY="22.499999329447768 pt">
<arrowlink SHAPE="LINE" COLOR="#999999" WIDTH="2" TRANSPARENCY="200" DASH="7 7" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_1133460403" STARTINCLINATION="32;24;" ENDINCLINATION="7;-14;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
</node>
<node TEXT="parsing" ID="ID_1037819328" CREATED="1649843652713" MODIFIED="1651494699656" HGAP_QUANTITY="16.249999932944778 pt" VSHIFT_QUANTITY="-36.74999890476468 pt">
<node TEXT="bwa &gt; *.bed" ID="ID_1133460403" CREATED="1649843943849" MODIFIED="1649844964613"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      &quot;bwa_align/out_parse&quot;
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="STAR (bash#1) &gt; * bed" ID="ID_1406976541" CREATED="1649843993469" MODIFIED="1649845060350" BACKGROUND_COLOR="#ff3399" HGAP_QUANTITY="14.749999977648258 pt" VSHIFT_QUANTITY="26.99999919533732 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      &quot;STAR_align/STAR_out&quot;
    </p>
  </body>
</html>
</richcontent>
<node TEXT="decision: run the other 2 as well?" ID="ID_1920956490" CREATED="1649844991710" MODIFIED="1649845022636" BACKGROUND_COLOR="#ff3399"/>
</node>
</node>
<node TEXT="annotating" ID="ID_834746018" CREATED="1649843667680" MODIFIED="1649843671826"/>
</node>
</node>
<node TEXT="vis circRNAs" ID="ID_628708451" CREATED="1540769969570" MODIFIED="1651494733726" HGAP_QUANTITY="19.24999984353781 pt" VSHIFT_QUANTITY="34.499998971819906 pt">
<node TEXT="CIRI_VIS (&gt;.pdf)" ID="ID_497134942" CREATED="1540769973970" MODIFIED="1651494744281" HGAP_QUANTITY="163.99999552965178 pt" VSHIFT_QUANTITY="-2.2499999329447764 pt">
<node ID="ID_457705798" CREATED="1649944650447" MODIFIED="1649944650447"><richcontent TYPE="NODE">

<html>
  <head>
    
  </head>
  <body>
    <p>
      .bed or other output from circRNA ID software
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
</node>
<node TEXT="DE circRNAs" ID="ID_50821657" CREATED="1649768390239" MODIFIED="1651494715271" HGAP_QUANTITY="21.49999977648259 pt" VSHIFT_QUANTITY="42.74999872595075 pt">
<node TEXT="CIRIquant" ID="ID_165901317" CREATED="1649770607502" MODIFIED="1651494715270" HGAP_QUANTITY="16.999999910593036 pt" VSHIFT_QUANTITY="14.249999575316918 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">&quot;/analysis_CIRI2_full/&quot; </font>
    </p>
    <p>
      <font size="1">&quot;/with_CIRI_DE_sep/&quot; or &quot;/without_CIRI_DE/&quot;</font>
    </p>
  </body>
</html>

</richcontent>
<node TEXT="1. quantification" ID="ID_1556292993" CREATED="1649772670820" MODIFIED="1649836239005" HGAP_QUANTITY="9.500000134110447 pt" VSHIFT_QUANTITY="0.7499999776482589 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      &quot;/sX_quant/&quot;
    </p>
  </body>
</html>
</richcontent>
<node TEXT="&gt; .gtf" ID="ID_1428888220" CREATED="1649776149322" MODIFIED="1651493863283" HGAP_QUANTITY="16.249999932944775 pt" VSHIFT_QUANTITY="-11.999999642372142 pt">
<arrowlink SHAPE="LINE" COLOR="#999999" WIDTH="2" TRANSPARENCY="200" DASH="7 7" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_1324687390" STARTINCLINATION="4;33;" ENDINCLINATION="-60;-10;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
<node TEXT="&gt; /gene/_out.gtf" ID="ID_290193799" CREATED="1649776157858" MODIFIED="1651493746949" VSHIFT_QUANTITY="8.249999754130847 pt">
<arrowlink SHAPE="LINE" COLOR="#999999" WIDTH="2" TRANSPARENCY="200" DASH="7 7" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_1046473950" STARTINCLINATION="4;9;" ENDINCLINATION="19;-43;" STARTARROW="NONE" ENDARROW="DEFAULT"/>
</node>
</node>
<node TEXT="2. &gt; ?" ID="ID_802480546" CREATED="1649772703474" MODIFIED="1649773128084"/>
<node TEXT="3. DE" ID="ID_976522884" CREATED="1649772708197" MODIFIED="1649776489041">
<node TEXT="prep_CIRIquant" FOLDED="true" ID="ID_1324687390" CREATED="1649776312885" MODIFIED="1651493920130"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">&quot;/with_CIRI_DE_sep/&quot; or &quot;/without_CIRI_DE/&quot;</font>
    </p>
  </body>
</html>

</richcontent>
<node TEXT="_library_info.csv" ID="ID_1790193453" CREATED="1651493201387" MODIFIED="1651493275099"/>
<node TEXT="_circRNA_info.csv" ID="ID_12488056" CREATED="1651493278186" MODIFIED="1651493293110"/>
<node TEXT="_circRNA_bsj.csv" ID="ID_142961624" CREATED="1651493294104" MODIFIED="1651493304552"/>
<node TEXT="_circRNA_ratio.csv" ID="ID_1051112429" CREATED="1651493304986" MODIFIED="1651493310172"/>
</node>
<node TEXT="prepDE.py" ID="ID_1046473950" CREATED="1649776348935" MODIFIED="1649776489041" HGAP_QUANTITY="15.499999955296518 pt" VSHIFT_QUANTITY="15.749999530613437 pt">
<node TEXT="_gene_count_matrix.csv" ID="ID_822077844" CREATED="1651493486687" MODIFIED="1651493494807"/>
<node TEXT="_transcript_count_matrix.csv" ID="ID_1582980671" CREATED="1651493495468" MODIFIED="1651493502025"/>
</node>
<node TEXT="either" ID="ID_92961335" CREATED="1651237023033" MODIFIED="1651494892265">
<node TEXT="CIRI_DE_replicate" ID="ID_1071405047" CREATED="1651493132373" MODIFIED="1651494892265" HGAP_QUANTITY="13.250000022351742 pt" VSHIFT_QUANTITY="8.99999973177911 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">&quot;/gene_level/&quot; and &quot;/transcript_level&quot;</font>
    </p>
  </body>
</html>

</richcontent>
<node TEXT="total" ID="ID_902979079" CREATED="1651493211235" MODIFIED="1651494832757"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">&quot;_output_DEgene.csv&quot;</font>
    </p>
  </body>
</html>

</richcontent>
<node TEXT="dropped this whole branch because the were no genes with padj &lt; 0.05" ID="ID_1704272199" CREATED="1651496383525" MODIFIED="1651496426919" BACKGROUND_COLOR="#cccccc"/>
</node>
<node TEXT="sg" ID="ID_554754065" CREATED="1651493216956" MODIFIED="1651494864940"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">&quot;_output_DEgene.csv&quot;</font>
    </p>
  </body>
</html>

</richcontent>
</node>
<node TEXT="total vs sg" ID="ID_766370345" CREATED="1651493218615" MODIFIED="1651493245112" BACKGROUND_COLOR="#ffcccc"/>
</node>
<node TEXT="manual DE with DESeq2" ID="ID_1598576295" CREATED="1651493135392" MODIFIED="1651494883689" HGAP_QUANTITY="12.500000044703482 pt" VSHIFT_QUANTITY="17.99999946355821 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">R script &quot;Zhou_CIRIquantDESeq2.Rmd&quot;</font>
    </p>
  </body>
</html>

</richcontent>
<node TEXT="total" ID="ID_96591185" CREATED="1651493224525" MODIFIED="1651494848068"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">&quot;_output_DEgene.csv&quot;</font>
    </p>
  </body>
</html>

</richcontent>
</node>
<node TEXT="sg" ID="ID_1651863454" CREATED="1651493227275" MODIFIED="1651494877235"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      <font size="1">&quot;_output_DEgene.csv&quot;</font>
    </p>
  </body>
</html>

</richcontent>
</node>
<node TEXT="total vs sg" ID="ID_1069044585" CREATED="1651493228626" MODIFIED="1651493240562" BACKGROUND_COLOR="#ffcccc"/>
</node>
</node>
</node>
</node>
</node>
<node TEXT="enrichment in circRNA" ID="ID_1708822369" CREATED="1649942798454" MODIFIED="1649945664763" HGAP_QUANTITY="-0.2499995753169202 pt" VSHIFT_QUANTITY="38.249998860061204 pt" BACKGROUND_COLOR="#999999">
<node TEXT="use multiBamSummary: your reads in .bam + junction coordinates in .bed files" ID="ID_675208696" CREATED="1649942806469" MODIFIED="1649945659508" HGAP_QUANTITY="40.249999217689066 pt" VSHIFT_QUANTITY="528.7499842420225 pt">
<node TEXT="basically extract reads that overlap the junctions and count them" ID="ID_223613910" CREATED="1649942869076" MODIFIED="1649942893999"/>
<node TEXT="can use featureCounts(?)" ID="ID_1137166088" CREATED="1649942894646" MODIFIED="1649942904092"/>
</node>
<node TEXT="" ID="ID_1453943286" CREATED="1649945384581" MODIFIED="1649945664761" HGAP_QUANTITY="57.49999870359901 pt" VSHIFT_QUANTITY="-45.74999863654381 pt">
<node ID="ID_733158736" CREATED="1649945396319" MODIFIED="1649945404112" HGAP_QUANTITY="13.250000022351742 pt" VSHIFT_QUANTITY="47.99999856948857 pt"><richcontent TYPE="NODE">

<html>
  <head>
    
  </head>
  <body>
    <font face="Calibri,Arial,Helvetica,sans-serif" color="black" size="12pt"><span dir="ltr" style="font-size: 12pt; background-color: white"><b>Waiting for the abundance analysis</b></span></font>
  </body>
</html>
</richcontent>
</node>
</node>
<node TEXT="is it the same enrichment analysis as in the Molecular Cell paper?" ID="ID_1871276690" CREATED="1649945629279" MODIFIED="1649945661749" HGAP_QUANTITY="58.24999868124728 pt" VSHIFT_QUANTITY="-521.9999844431882 pt"/>
</node>
</node>
<node TEXT="overlap with m6A, eCLIP, FLASH data" POSITION="right" ID="ID_418833551" CREATED="1649945956987" MODIFIED="1649945996986" BACKGROUND_COLOR="#999999" HGAP_QUANTITY="19.24999984353781 pt" VSHIFT_QUANTITY="-15.749999530613437 pt">
<font BOLD="false"/>
</node>
<node TEXT="run future pipelines on both batch and no-batch data until decission" POSITION="left" ID="ID_1163462558" CREATED="1649944670884" MODIFIED="1649944690426"/>
<node TEXT="not done; maybe eventually" POSITION="left" ID="ID_780023835" CREATED="1651493048582" MODIFIED="1651493092399" BACKGROUND_COLOR="#ffcccc"/>
<node TEXT="conclusion" POSITION="left" ID="ID_1387745984" CREATED="1651496438048" MODIFIED="1651496446441" BACKGROUND_COLOR="#cccccc"/>
</node>
</map>
